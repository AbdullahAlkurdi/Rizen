import 'package:flutter_test/flutter_test.dart';
import 'package:rizen/features/finance/presentation/cubit/finance_cubit.dart';
import 'package:rizen/features/finance/data/models/budget_cycle_model.dart';
import 'package:rizen/features/finance/data/models/transaction_model.dart';

void main() {
  group('FinanceLoaded state calculations', () {
    test('budgetUsedPercent returns 0 when income is 0', () {
      final state = FinanceLoaded(
        transactions: [],
        commitments: [],
        cycles: [],
        currentCycle: null,
        dailyReviewSchedule: null,
      );

      expect(state.budgetUsedPercent, equals(0));
    });

    test('budgetUsedPercent returns 50% when spent is half of income', () {
      final cycle = BudgetCycle(
        id: 'cycle-id',
        uid: 'test-uid',
        monthlyIncome: 100,
        currency: 'USD',
        cycleStart: DateTime.now(),
        cycleEnd: DateTime.now().add(const Duration(days: 30)),
        totalSpent: 50,
        totalCommitted: 0,
        status: BudgetCycleStatus.active,
      );

      final state = FinanceLoaded(
        transactions: [],
        commitments: [],
        cycles: [cycle],
        currentCycle: cycle,
        dailyReviewSchedule: null,
      );

      expect(state.budgetUsedPercent, equals(50));
    });

    test('isOverBudget returns false when remaining is positive', () {
      final cycle = BudgetCycle(
        id: 'cycle-id',
        uid: 'test-uid',
        monthlyIncome: 100,
        currency: 'USD',
        cycleStart: DateTime.now(),
        cycleEnd: DateTime.now().add(const Duration(days: 30)),
        totalSpent: 50,
        totalCommitted: 20,
        status: BudgetCycleStatus.active,
      );

      final state = FinanceLoaded(
        transactions: [],
        commitments: [],
        cycles: [cycle],
        currentCycle: cycle,
        dailyReviewSchedule: null,
      );

      expect(state.isOverBudget, isFalse);
    });

    test('isOverBudget returns true when spent + committed exceeds income', () {
      final cycle = BudgetCycle(
        id: 'cycle-id',
        uid: 'test-uid',
        monthlyIncome: 100,
        currency: 'USD',
        cycleStart: DateTime.now(),
        cycleEnd: DateTime.now().add(const Duration(days: 30)),
        totalSpent: 60,
        totalCommitted: 50,
        status: BudgetCycleStatus.active,
      );

      final state = FinanceLoaded(
        transactions: [],
        commitments: [],
        cycles: [cycle],
        currentCycle: cycle,
        dailyReviewSchedule: null,
      );

      expect(state.isOverBudget, isTrue);
    });

    test('remaining is calculated correctly', () {
      final cycle = BudgetCycle(
        id: 'cycle-id',
        uid: 'test-uid',
        monthlyIncome: 100,
        currency: 'USD',
        cycleStart: DateTime.now(),
        cycleEnd: DateTime.now().add(const Duration(days: 30)),
        totalSpent: 30,
        totalCommitted: 40,
        status: BudgetCycleStatus.active,
      );

      final state = FinanceLoaded(
        transactions: [],
        commitments: [],
        cycles: [cycle],
        currentCycle: cycle,
        dailyReviewSchedule: null,
      );

      expect(state.remaining, equals(30));
    });

    test('currency defaults to SAR when no cycle', () {
      final state = FinanceLoaded(
        transactions: [],
        commitments: [],
        cycles: [],
        currentCycle: null,
        dailyReviewSchedule: null,
      );

      expect(state.currency, equals('SAR'));
    });

    test('spent is calculated from transactions when no cycle', () {
      final state = FinanceLoaded(
        transactions: [
          Transaction(
            id: 't1',
            uid: 'test-uid',
            amount: 25.50,
            currency: 'USD',
            description: 'Test expense',
            type: TransactionType.expense,
            source: TransactionSource.manual,
            loggedAt: DateTime.now(),
            createdAt: DateTime.now(),
          ),
        ],
        commitments: [],
        cycles: [],
        currentCycle: null,
        dailyReviewSchedule: null,
      );

      expect(state.spent, equals(25.50));
    });
  });
}