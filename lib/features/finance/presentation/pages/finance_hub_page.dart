import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../cubit/finance_cubit.dart';

class FinanceHubPage extends StatefulWidget {
  const FinanceHubPage({super.key});

  @override
  State<FinanceHubPage> createState() => _FinanceHubPageState();
}

class _FinanceHubPageState extends State<FinanceHubPage> {
  @override
  void initState() {
    super.initState();
    context.read<FinanceCubit>().closeExpiredCycleIfNeeded();
  }

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      extendBody: true,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      body: BlocBuilder<FinanceCubit, FinanceState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () => context.read<FinanceCubit>().loadFinance(),
            child: ListView(
              children: [
                const PageHeader(
                  title: 'Personal Finance',
                  subtitle: 'Budget visibility without spreadsheet discipline.',
                ),
                const SizedBox(height: 20),
                if (state is FinanceLoading)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: SkeletonCard(height: 160),
                  )
                else if (state is FinanceError)
                  GlassCard(child: Text(state.message))
                else if (state is FinanceLoaded)
                  Column(
                    children: [
                      _SummaryCard(state: state),
                      if (state.dailyReviewSchedule?.isDue ?? false) ...[
                        const SizedBox(height: 12),
                        GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Daily review is due',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'You logged ${state.transactions.length} item${state.transactions.length == 1 ? '' : 's'} this cycle. Check today before it closes.',
                              ),
                              const SizedBox(height: 12),
                              RizenButton(
                                label: 'Review Today',
                                icon: PhosphorIconsBold.listChecks,
                                onPressed: () async {
                                  await context
                                      .read<FinanceCubit>()
                                      .markDailyReviewPrompted();
                                  if (context.mounted) {
                                    context.push(AppRoutes.financeDailyReview);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  )
                else
                  const GlassCard(child: Text('Finance is ready.')),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: RizenButton(
                        label: 'Quick Entry',
                        icon: PhosphorIconsBold.lightning,
                        onPressed: () =>
                            context.push(AppRoutes.financeQuickEntry),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RizenButton(
                        label: 'Manual',
                        icon: PhosphorIconsBold.plus,
                        variant: RizenButtonVariant.secondary,
                        onPressed: () => context.push(AppRoutes.financeManual),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                NavGlassTile(
                  title: 'Commitments',
                  subtitle: 'Recurring rent, subscriptions, and fixed costs.',
                  icon: PhosphorIconsBold.calendarCheck,
                  iconColor: AppColors.warning,
                  onTap: () => context.push(AppRoutes.financeCommitments),
                ),
                const SizedBox(height: 10),
                NavGlassTile(
                  title: 'Daily Review',
                  subtitle: 'Reconcile today before the day closes.',
                  icon: PhosphorIconsBold.listChecks,
                  iconColor: AppColors.success,
                  onTap: () => context.push(AppRoutes.financeDailyReview),
                ),
                const SizedBox(height: 10),
                NavGlassTile(
                  title: 'Monthly Report',
                  subtitle: 'Income, spent, remaining, and categories.',
                  icon: PhosphorIconsBold.chartPieSlice,
                  iconColor: const Color(0xFF60A5FA),
                  onTap: () => context.push(AppRoutes.financeMonthlyReport),
                ),
                const SizedBox(height: 10),
                NavGlassTile(
                  title: 'Emergency Expense',
                  subtitle: 'Amount and description only.',
                  icon: PhosphorIconsBold.warning,
                  iconColor: AppColors.accent,
                  onTap: () => context.push(AppRoutes.financeEmergencyExpense),
                ),
                const SizedBox(height: 10),
                NavGlassTile(
                  title: 'Finance Settings',
                  subtitle: 'Currency and cycle start day.',
                  icon: PhosphorIconsBold.gear,
                  iconColor: AppColors.textSecondary,
                  onTap: () => context.push(AppRoutes.financeSettings),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.state});

  final FinanceLoaded state;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Current Cycle', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Row(
            children: [
              _Metric(
                label: 'Income',
                value: _money(state.income, state.currency),
              ),
              _Metric(
                label: 'Spent',
                value: _money(state.spent, state.currency),
              ),
              _Metric(
                label: 'Remaining',
                value: _money(state.remaining, state.currency),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            state.isOverBudget
                ? '${state.budgetUsedPercent.toStringAsFixed(0)}% of this cycle budget used'
                : '${state.budgetUsedPercent.toStringAsFixed(0)}% used',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: state.isOverBudget
                  ? AppColors.accent
                  : AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: state.income <= 0
                ? 0
                : ((state.spent + state.committed) / state.income).clamp(0, 1),
            color: state.remaining < 0 ? AppColors.accent : AppColors.success,
            backgroundColor: AppColors.glassFill,
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: Theme.of(context).textTheme.titleMedium),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

String _money(double value, [String currency = 'SAR']) =>
    '${value.toStringAsFixed(2)} $currency';
