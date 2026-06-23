import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_auth/firebase_auth.dart';

import '../models/budget_cycle_model.dart';
import '../models/daily_review_schedule_model.dart';
import '../models/financial_commitment_model.dart';
import '../models/transaction_model.dart';

abstract class FinanceRepositoryBase {
  Future<Transaction> addTransaction({
    required double amount,
    required String description,
    String currency = 'SAR',
    String? category,
    required TransactionType type,
    TransactionSource source = TransactionSource.manual,
    DateTime? loggedAt,
  });

  Future<Transaction?> getTransaction(String transactionId);
  Future<List<Transaction>> getTransactions();
  Future<List<Transaction>> getTransactionsForCycle(BudgetCycle cycle);
  Future<void> updateTransaction(Transaction transaction);
  Future<void> deleteTransaction(String transactionId);

  Future<FinancialCommitment> addCommitment({
    required String name,
    required double amount,
    required CommitmentFrequency frequency,
    DateTime? nextDueDate,
  });

  Future<FinancialCommitment?> getCommitment(String commitmentId);
  Future<List<FinancialCommitment>> getCommitments();
  Future<void> updateCommitment(FinancialCommitment commitment);
  Future<void> deactivateCommitment(String commitmentId);
  Future<void> reactivateCommitment(String commitmentId);
  Future<void> deleteCommitment(String commitmentId);

  Future<BudgetCycle> createBudgetCycle({
    required double monthlyIncome,
    String currency = 'SAR',
    DateTime? cycleStart,
    DateTime? cycleEnd,
  });

  Future<BudgetCycle?> getBudgetCycle(String cycleId);
  Future<List<BudgetCycle>> getBudgetCycles();
  Future<BudgetCycle?> getCurrentCycle();
  Future<void> updateBudgetCycle(BudgetCycle cycle);
  Future<void> deleteBudgetCycle(String cycleId);
  Future<BudgetCycle> closeCycleAndStartNew();
  Future<double> getActiveCommittedTotal();
  Future<DailyReviewSchedule> getDailyReviewSchedule();
  Future<void> updateDailyReviewSchedule(DailyReviewSchedule schedule);
  Future<void> markDailyReviewPrompted();
}

class FinanceRepository implements FinanceRepositoryBase {
  FinanceRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CollectionReference get _transactions =>
      _firestore.collection('transactions');
  CollectionReference get _commitments =>
      _firestore.collection('financial_commitments');
  CollectionReference get _budgetCycles =>
      _firestore.collection('budget_cycles');
  DocumentReference get _dailyReviewSchedule => _firestore
      .collection('users')
      .doc(_uid)
      .collection('finance_settings')
      .doc('daily_review');

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  @override
  Future<Transaction> addTransaction({
    required double amount,
    required String description,
    String currency = 'SAR',
    String? category,
    required TransactionType type,
    TransactionSource source = TransactionSource.manual,
    DateTime? loggedAt,
  }) async {
    final uid = _uid;
    final ref = _transactions.doc();
    final now = DateTime.now();
    final transaction = Transaction(
      id: ref.id,
      uid: uid,
      amount: amount,
      currency: currency,
      description: description,
      category: category,
      type: type,
      source: source,
      loggedAt: loggedAt ?? now,
      createdAt: now,
    );

    await ref.set({
      ...transaction.toFirestore(),
      'createdAt': FieldValue.serverTimestamp(),
      'loggedAt': Timestamp.fromDate(transaction.loggedAt),
    });
    await _refreshActiveCycleTotals();
    return transaction;
  }

  @override
  Future<Transaction?> getTransaction(String transactionId) async {
    final uid = _uid;
    final doc = await _transactions.doc(transactionId).get();
    if (!doc.exists) return null;
    final transaction = Transaction.fromFirestore(doc);
    if (transaction.uid != uid) throw Exception('Unauthorized');
    return transaction;
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    final uid = _uid;
    final snapshot = await _transactions
        .where('uid', isEqualTo: uid)
        .orderBy('loggedAt', descending: true)
        .get();
    return snapshot.docs.map(Transaction.fromFirestore).toList();
  }

  @override
  Future<List<Transaction>> getTransactionsForCycle(BudgetCycle cycle) async {
    final uid = _uid;
    final snapshot = await _transactions
        .where('uid', isEqualTo: uid)
        .where('loggedAt', isGreaterThanOrEqualTo: cycle.cycleStart)
        .where('loggedAt', isLessThanOrEqualTo: cycle.cycleEnd)
        .orderBy('loggedAt', descending: true)
        .get();
    return snapshot.docs.map(Transaction.fromFirestore).toList();
  }

  @override
  Future<void> updateTransaction(Transaction transaction) async {
    final existing = await getTransaction(transaction.id);
    if (existing == null) throw Exception('Transaction not found');
    if (existing.uid != transaction.uid || transaction.uid != _uid) {
      throw Exception('Unauthorized');
    }
    await _transactions.doc(transaction.id).update(transaction.toFirestore());
    await _refreshActiveCycleTotals();
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    final transaction = await getTransaction(transactionId);
    if (transaction == null) return;
    await _transactions.doc(transactionId).delete();
    await _refreshActiveCycleTotals();
  }

  @override
  Future<FinancialCommitment> addCommitment({
    required String name,
    required double amount,
    required CommitmentFrequency frequency,
    DateTime? nextDueDate,
  }) async {
    final uid = _uid;
    final ref = _commitments.doc();
    final now = DateTime.now();
    final commitment = FinancialCommitment(
      id: ref.id,
      uid: uid,
      name: name,
      amount: amount,
      frequency: frequency,
      nextDueDate: nextDueDate ?? now,
      active: true,
      createdAt: now,
    );

    await ref.set({
      ...commitment.toFirestore(),
      'createdAt': FieldValue.serverTimestamp(),
    });
    await _refreshActiveCycleTotals();
    return commitment;
  }

  @override
  Future<FinancialCommitment?> getCommitment(String commitmentId) async {
    final uid = _uid;
    final doc = await _commitments.doc(commitmentId).get();
    if (!doc.exists) return null;
    final commitment = FinancialCommitment.fromFirestore(doc);
    if (commitment.uid != uid) throw Exception('Unauthorized');
    return commitment;
  }

  @override
  Future<List<FinancialCommitment>> getCommitments() async {
    final uid = _uid;
    final snapshot = await _commitments
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map(FinancialCommitment.fromFirestore).toList();
  }

  @override
  Future<void> updateCommitment(FinancialCommitment commitment) async {
    final existing = await getCommitment(commitment.id);
    if (existing == null) throw Exception('Commitment not found');
    if (existing.uid != commitment.uid || commitment.uid != _uid) {
      throw Exception('Unauthorized');
    }
    await _commitments.doc(commitment.id).update(commitment.toFirestore());
    await _refreshActiveCycleTotals();
  }

  @override
  Future<void> deactivateCommitment(String commitmentId) async {
    final commitment = await getCommitment(commitmentId);
    if (commitment == null) return;
    await _commitments.doc(commitmentId).update({'active': false});
    await _refreshActiveCycleTotals();
  }

  @override
  Future<void> reactivateCommitment(String commitmentId) async {
    final commitment = await getCommitment(commitmentId);
    if (commitment == null) return;
    await _commitments.doc(commitmentId).update({'active': true});
    await _refreshActiveCycleTotals();
  }

  @override
  Future<void> deleteCommitment(String commitmentId) async {
    final commitment = await getCommitment(commitmentId);
    if (commitment == null) return;
    await _commitments.doc(commitmentId).delete();
    await _refreshActiveCycleTotals();
  }

  @override
  Future<BudgetCycle> createBudgetCycle({
    required double monthlyIncome,
    String currency = 'SAR',
    DateTime? cycleStart,
    DateTime? cycleEnd,
  }) async {
    final uid = _uid;
    final ref = _budgetCycles.doc();
    final start = cycleStart ?? DateTime.now();
    final cycle = BudgetCycle(
      id: ref.id,
      uid: uid,
      monthlyIncome: monthlyIncome,
      currency: currency,
      cycleStart: start,
      cycleEnd: cycleEnd ?? DateTime(start.year, start.month + 1, start.day),
      totalSpent: 0,
      totalCommitted: await getActiveCommittedTotal(),
      status: BudgetCycleStatus.active,
    );

    await ref.set(cycle.toFirestore());
    return cycle;
  }

  @override
  Future<BudgetCycle?> getBudgetCycle(String cycleId) async {
    final uid = _uid;
    final doc = await _budgetCycles.doc(cycleId).get();
    if (!doc.exists) return null;
    final cycle = BudgetCycle.fromFirestore(doc);
    if (cycle.uid != uid) throw Exception('Unauthorized');
    return cycle;
  }

  @override
  Future<List<BudgetCycle>> getBudgetCycles() async {
    final uid = _uid;
    final snapshot = await _budgetCycles
        .where('uid', isEqualTo: uid)
        .orderBy('cycleStart', descending: true)
        .get();
    return snapshot.docs.map(BudgetCycle.fromFirestore).toList();
  }

  @override
  Future<BudgetCycle?> getCurrentCycle() async {
    final uid = _uid;
    final snapshot = await _budgetCycles
        .where('uid', isEqualTo: uid)
        .where('status', isEqualTo: BudgetCycleStatus.active.name)
        .orderBy('cycleStart', descending: true)
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) return null;
    return BudgetCycle.fromFirestore(snapshot.docs.first);
  }

  @override
  Future<void> updateBudgetCycle(BudgetCycle cycle) async {
    final existing = await getBudgetCycle(cycle.id);
    if (existing == null) throw Exception('Budget cycle not found');
    if (existing.uid != cycle.uid || cycle.uid != _uid) {
      throw Exception('Unauthorized');
    }
    await _budgetCycles.doc(cycle.id).update(cycle.toFirestore());
  }

  @override
  Future<void> deleteBudgetCycle(String cycleId) async {
    final cycle = await getBudgetCycle(cycleId);
    if (cycle == null) return;
    await _budgetCycles.doc(cycleId).delete();
  }

  @override
  Future<BudgetCycle> closeCycleAndStartNew() async {
    final current = await getCurrentCycle();
    if (current == null) {
      return createBudgetCycle(monthlyIncome: 0);
    }
    await _budgetCycles.doc(current.id).update({
      'status': BudgetCycleStatus.closed.name,
    });
    final nextStart = current.cycleEnd.add(const Duration(days: 1));
    return createBudgetCycle(
      monthlyIncome: current.monthlyIncome,
      currency: current.currency,
      cycleStart: nextStart,
      cycleEnd: DateTime(nextStart.year, nextStart.month + 1, nextStart.day),
    );
  }

  @override
  Future<double> getActiveCommittedTotal() async {
    final commitments = await getCommitments();
    return commitments
        .where((commitment) => commitment.active)
        .fold<double>(0, (total, commitment) => total + commitment.amount);
  }

  @override
  Future<DailyReviewSchedule> getDailyReviewSchedule() async {
    final doc = await _dailyReviewSchedule.get();
    if (doc.exists) return DailyReviewSchedule.fromFirestore(doc);

    final schedule = DailyReviewSchedule(
      uid: _uid,
      enabled: true,
      reviewHour: 21,
      reviewMinute: 0,
      nextReviewAt: _nextReviewAt(hour: 21, minute: 0),
    );
    await updateDailyReviewSchedule(schedule);
    return schedule;
  }

  @override
  Future<void> updateDailyReviewSchedule(DailyReviewSchedule schedule) async {
    if (schedule.uid != _uid) throw Exception('Unauthorized');
    await _dailyReviewSchedule.set(schedule.toFirestore());
  }

  @override
  Future<void> markDailyReviewPrompted() async {
    final schedule = await getDailyReviewSchedule();
    await updateDailyReviewSchedule(
      schedule.copyWith(
        lastPromptedAt: DateTime.now(),
        nextReviewAt: _nextReviewAt(
          hour: schedule.reviewHour,
          minute: schedule.reviewMinute,
          from: DateTime.now().add(const Duration(days: 1)),
        ),
      ),
    );
  }

  Future<void> _refreshActiveCycleTotals() async {
    final cycle = await getCurrentCycle();
    if (cycle == null) return;
    final transactions = await getTransactionsForCycle(cycle);
    final spent = transactions
        .where((transaction) => transaction.type == TransactionType.expense)
        .fold<double>(0, (total, transaction) => total + transaction.amount);
    final committed = await getActiveCommittedTotal();
    await _budgetCycles.doc(cycle.id).update({
      'totalSpent': spent,
      'totalCommitted': committed,
    });
  }
}

DateTime _nextReviewAt({
  required int hour,
  required int minute,
  DateTime? from,
}) {
  final now = from ?? DateTime.now();
  var next = DateTime(now.year, now.month, now.day, hour, minute);
  if (!next.isAfter(now)) next = next.add(const Duration(days: 1));
  return next;
}
