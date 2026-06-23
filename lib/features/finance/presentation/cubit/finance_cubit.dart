import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/budget_cycle_model.dart';
import '../../data/models/daily_review_schedule_model.dart';
import '../../data/models/financial_commitment_model.dart';
import '../../data/models/transaction_model.dart';
import '../../data/repositories/finance_repository.dart';
import '../../data/services/finance_quick_entry_parser.dart';

sealed class FinanceState {}

final class FinanceInitial extends FinanceState {}

final class FinanceLoading extends FinanceState {}

final class FinanceLoaded extends FinanceState {
  FinanceLoaded({
    required this.transactions,
    required this.commitments,
    required this.cycles,
    this.currentCycle,
    this.dailyReviewSchedule,
    this.parsedTransaction,
    this.manualFallbackInput,
    this.manualFallbackReason,
  });

  final List<Transaction> transactions;
  final List<FinancialCommitment> commitments;
  final List<BudgetCycle> cycles;
  final BudgetCycle? currentCycle;
  final DailyReviewSchedule? dailyReviewSchedule;
  final ParsedTransaction? parsedTransaction;
  final String? manualFallbackInput;
  final String? manualFallbackReason;

  double get spent => currentCycle?.totalSpent ?? _transactionSpent;
  double get committed => currentCycle?.totalCommitted ?? _activeCommitted;
  double get income => currentCycle?.monthlyIncome ?? _transactionIncome;
  double get remaining => income - spent - committed;
  String get currency => currentCycle?.currency ?? 'SAR';
  bool get isOverBudget => income > 0 && spent + committed > income;
  double get budgetUsedPercent =>
      income <= 0 ? 0 : ((spent + committed) / income) * 100;

  double get _transactionSpent => transactions
      .where((transaction) => transaction.type == TransactionType.expense)
      .fold<double>(0, (total, transaction) => total + transaction.amount);

  double get _transactionIncome => transactions
      .where((transaction) => transaction.type == TransactionType.income)
      .fold<double>(0, (total, transaction) => total + transaction.amount);

  double get _activeCommitted => commitments
      .where((commitment) => commitment.active)
      .fold<double>(0, (total, commitment) => total + commitment.amount);
}

final class FinanceError extends FinanceState {
  FinanceError(this.message);

  final String message;
}

class ParsedTransaction {
  const ParsedTransaction({
    required this.amount,
    required this.description,
    this.category,
    this.type = TransactionType.expense,
  });

  final double amount;
  final String description;
  final String? category;
  final TransactionType type;
}

class FinanceCubit extends Cubit<FinanceState> {
  FinanceCubit({
    FinanceRepositoryBase? repository,
    FinanceQuickEntryParser? quickEntryParser,
  }) : _repository = repository ?? FinanceRepository(),
       _quickEntryParser = quickEntryParser ?? GeminiFinanceQuickEntryParser(),
       super(FinanceInitial());

  final FinanceRepositoryBase _repository;
  final FinanceQuickEntryParser _quickEntryParser;

  Future<void> loadFinance() async {
    emit(FinanceLoading());
    try {
      emit(await _load());
    } catch (e) {
      emit(FinanceError(e.toString()));
    }
  }

  Future<void> parseQuickEntry(String input) async {
    try {
      final current = state;
      final parsedEntry = await _quickEntryParser
          .parse(input)
          .timeout(const Duration(seconds: 2));
      final parsed = ParsedTransaction(
        amount: parsedEntry.amount,
        description: parsedEntry.description,
        category: parsedEntry.category,
        type: parsedEntry.type,
      );
      if (current is FinanceLoaded) {
        emit(
          FinanceLoaded(
            transactions: current.transactions,
            commitments: current.commitments,
            cycles: current.cycles,
            currentCycle: current.currentCycle,
            dailyReviewSchedule: current.dailyReviewSchedule,
            parsedTransaction: parsed,
          ),
        );
      } else {
        emit(await _load(parsedTransaction: parsed));
      }
    } catch (_) {
      final fallbackInput = FinancePiiStripper.strip(input);
      const fallbackReason =
          'Quick entry could not be parsed in 2 seconds. Use manual entry.';
      final current = state;
      if (current is FinanceLoaded) {
        emit(
          FinanceLoaded(
            transactions: current.transactions,
            commitments: current.commitments,
            cycles: current.cycles,
            currentCycle: current.currentCycle,
            dailyReviewSchedule: current.dailyReviewSchedule,
            manualFallbackInput: fallbackInput,
            manualFallbackReason: fallbackReason,
          ),
        );
      } else {
        emit(
          await _load(
            manualFallbackInput: fallbackInput,
            manualFallbackReason: fallbackReason,
          ),
        );
      }
    }
  }

  Future<void> addTransaction({
    required double amount,
    required String description,
    String currency = 'SAR',
    String? category,
    required TransactionType type,
    required TransactionSource source,
  }) async {
    emit(FinanceLoading());
    try {
      await _repository.addTransaction(
        amount: amount,
        description: description,
        currency: currency,
        category: category,
        type: type,
        source: source,
      );
      emit(await _load());
    } catch (e) {
      emit(FinanceError(e.toString()));
    }
  }

  Future<void> deleteTransaction(String transactionId) async {
    emit(FinanceLoading());
    try {
      await _repository.deleteTransaction(transactionId);
      emit(await _load());
    } catch (e) {
      emit(FinanceError(e.toString()));
    }
  }

  Future<void> addCommitment({
    required String name,
    required double amount,
    required CommitmentFrequency frequency,
  }) async {
    emit(FinanceLoading());
    try {
      await _repository.addCommitment(
        name: name,
        amount: amount,
        frequency: frequency,
      );
      emit(await _load());
    } catch (e) {
      emit(FinanceError(e.toString()));
    }
  }

  Future<void> updateCommitment(FinancialCommitment commitment) async {
    emit(FinanceLoading());
    try {
      await _repository.updateCommitment(commitment);
      emit(await _load());
    } catch (e) {
      emit(FinanceError(e.toString()));
    }
  }

  Future<void> deactivateCommitment(String commitmentId) async {
    emit(FinanceLoading());
    try {
      await _repository.deactivateCommitment(commitmentId);
      emit(await _load());
    } catch (e) {
      emit(FinanceError(e.toString()));
    }
  }

  Future<void> reactivateCommitment(String commitmentId) async {
    emit(FinanceLoading());
    try {
      await _repository.reactivateCommitment(commitmentId);
      emit(await _load());
    } catch (e) {
      emit(FinanceError(e.toString()));
    }
  }

  Future<void> saveBudgetSettings({
    required double monthlyIncome,
    required String currency,
    required int cycleStartDay,
    bool dailyReviewEnabled = true,
    int reviewHour = 21,
    int reviewMinute = 0,
  }) async {
    emit(FinanceLoading());
    try {
      final now = DateTime.now();
      final start = DateTime(now.year, now.month, cycleStartDay);
      final end = DateTime(start.year, start.month + 1, start.day);
      final current = await _repository.getCurrentCycle();
      if (current == null) {
        await _repository.createBudgetCycle(
          monthlyIncome: monthlyIncome,
          currency: currency,
          cycleStart: start,
          cycleEnd: end,
        );
      } else {
        await _repository.updateBudgetCycle(
          current.copyWith(
            monthlyIncome: monthlyIncome,
            currency: currency,
            cycleStart: start,
            cycleEnd: end,
          ),
        );
      }
      final schedule = await _repository.getDailyReviewSchedule();
      await _repository.updateDailyReviewSchedule(
        schedule.copyWith(
          enabled: dailyReviewEnabled,
          reviewHour: reviewHour,
          reviewMinute: reviewMinute,
          nextReviewAt: _nextReviewAt(hour: reviewHour, minute: reviewMinute),
        ),
      );
      emit(await _load());
    } catch (e) {
      emit(FinanceError(e.toString()));
    }
  }

  Future<void> closeCycleAndStartNew() async {
    emit(FinanceLoading());
    try {
      await _repository.closeCycleAndStartNew();
      emit(await _load());
    } catch (e) {
      emit(FinanceError(e.toString()));
    }
  }

  Future<void> markDailyReviewPrompted() async {
    try {
      await _repository.markDailyReviewPrompted();
      emit(await _load());
    } catch (e) {
      emit(FinanceError(e.toString()));
    }
  }

  Future<void> closeExpiredCycleIfNeeded() async {
    try {
      final current = await _repository.getCurrentCycle();
      if (current != null && current.cycleEnd.isBefore(DateTime.now())) {
        await _repository.closeCycleAndStartNew();
      }
      emit(await _load());
    } catch (e) {
      emit(FinanceError(e.toString()));
    }
  }

  Future<FinanceLoaded> _load({
    ParsedTransaction? parsedTransaction,
    String? manualFallbackInput,
    String? manualFallbackReason,
  }) async {
    final currentCycle = await _repository.getCurrentCycle();
    final transactions = currentCycle == null
        ? await _repository.getTransactions()
        : await _repository.getTransactionsForCycle(currentCycle);
    return FinanceLoaded(
      transactions: transactions,
      commitments: await _repository.getCommitments(),
      cycles: await _repository.getBudgetCycles(),
      currentCycle: currentCycle,
      dailyReviewSchedule: await _repository.getDailyReviewSchedule(),
      parsedTransaction: parsedTransaction,
      manualFallbackInput: manualFallbackInput,
      manualFallbackReason: manualFallbackReason,
    );
  }
}

DateTime _nextReviewAt({required int hour, required int minute}) {
  final now = DateTime.now();
  var next = DateTime(now.year, now.month, now.day, hour, minute);
  if (!next.isAfter(now)) next = next.add(const Duration(days: 1));
  return next;
}
