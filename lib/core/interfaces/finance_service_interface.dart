import '../../features/finance/data/models/transaction_model.dart';
import '../../features/finance/data/models/budget_cycle_model.dart';

export '../../features/finance/data/models/transaction_model.dart';
export '../../features/finance/data/models/budget_cycle_model.dart';

abstract class FinanceServiceInterface {
  Future<List<Transaction>> getTodayTransactions();
  Future<BudgetCycle> getCurrentBudgetCycle();
  Future<List<Transaction>> getTransactions();
  Future<Transaction> addTransaction({
    required double amount,
    required String description,
    String currency = 'SAR',
    String? category,
    required TransactionType type,
    TransactionSource source = TransactionSource.manual,
    DateTime? loggedAt,
  });
}