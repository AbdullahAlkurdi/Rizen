import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../data/models/transaction_model.dart';
import '../cubit/finance_cubit.dart';

class MonthlyReportPage extends StatefulWidget {
  const MonthlyReportPage({super.key});

  @override
  State<MonthlyReportPage> createState() => _MonthlyReportPageState();
}

class _MonthlyReportPageState extends State<MonthlyReportPage> {
  @override
  void initState() {
    super.initState();
    context.read<FinanceCubit>().loadFinance();
  }

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Monthly Report',
      subtitle: 'Income vs spent vs remaining, with category breakdown.',
      body: BlocBuilder<FinanceCubit, FinanceState>(
        builder: (context, state) {
          if (state is FinanceLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is! FinanceLoaded) {
            return const Center(child: Text('No report data yet.'));
          }
          final categories = <String, double>{};
          for (final transaction in state.transactions) {
            if (transaction.type != TransactionType.expense) continue;
            final key = transaction.category ?? 'Uncategorized';
            categories[key] = (categories[key] ?? 0) + transaction.amount;
          }

          return ListView(
            children: [
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ReportRow(label: 'Income', value: state.income, currency: state.currency),
                    _ReportRow(label: 'Spent', value: state.spent, currency: state.currency),
                    _ReportRow(label: 'Committed', value: state.committed, currency: state.currency),
                    _ReportRow(label: 'Remaining', value: state.remaining, currency: state.currency),
                    _ReportRow(
                      label: 'Budget used',
                      value: state.budgetUsedPercent,
                      suffix: '%',
                      decimals: 0,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Categories',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              if (categories.isEmpty)
                const GlassCard(child: Text('No expense categories yet.'))
              else
                ...categories.entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text(entry.key)),
                              Text('${entry.value.toStringAsFixed(2)} ${state.currency}'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: state.spent <= 0
                                ? 0
                                : (entry.value / state.spent).clamp(0, 1),
                            color: AppColors.accent,
                            backgroundColor: AppColors.glassFill,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _ReportRow extends StatelessWidget {
  const _ReportRow({
    required this.label,
    required this.value,
    this.currency = 'SAR',
    this.suffix,
    this.decimals = 2,
  });

  final String label;
  final double value;
  final String currency;
  final String? suffix;
  final int decimals;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(suffix == null
              ? '${value.toStringAsFixed(decimals)} $currency'
              : '${value.toStringAsFixed(decimals)}$suffix'),
        ],
      ),
    );
  }
}
