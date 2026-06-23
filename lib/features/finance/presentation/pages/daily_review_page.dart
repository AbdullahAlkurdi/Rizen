import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../data/models/transaction_model.dart';
import '../cubit/finance_cubit.dart';

class DailyReviewPage extends StatefulWidget {
  const DailyReviewPage({super.key});

  @override
  State<DailyReviewPage> createState() => _DailyReviewPageState();
}

class _DailyReviewPageState extends State<DailyReviewPage> {
  @override
  void initState() {
    super.initState();
    context.read<FinanceCubit>().loadFinance();
  }

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Daily Review',
      subtitle: 'You can add anything missed today before closing the day.',
      body: BlocBuilder<FinanceCubit, FinanceState>(
        builder: (context, state) {
          if (state is FinanceLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final today = DateTime.now();
          final transactions = state is FinanceLoaded
              ? state.transactions.where((transaction) {
                  final date = transaction.loggedAt;
                  return date.year == today.year &&
                      date.month == today.month &&
                      date.day == today.day;
                }).toList()
              : <Transaction>[];
          final total = transactions
              .where(
                (transaction) => transaction.type == TransactionType.expense,
              )
              .fold<double>(0, (sum, transaction) => sum + transaction.amount);

          return ListView(
            children: [
              GlassCard(
                child: Text(
                  'Today: ${transactions.length} item${transactions.length == 1 ? '' : 's'} · ${total.toStringAsFixed(2)} SAR',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 14),
              if (transactions.isEmpty)
                const GlassCard(child: Text('No transactions logged today.'))
              else
                ...transactions.map(
                  (transaction) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GlassCard(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(transaction.description),
                        subtitle: Text(transaction.category ?? 'Uncategorized'),
                        trailing: Text(transaction.amount.toStringAsFixed(2)),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 18),
              RizenButton(
                label: 'Add Missed Expense',
                onPressed: () => context.push(AppRoutes.financeQuickEntry),
              ),
            ],
          );
        },
      ),
    );
  }
}
