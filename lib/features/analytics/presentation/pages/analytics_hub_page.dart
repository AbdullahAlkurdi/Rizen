import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../cubit/analytics_cubit.dart';

class AnalyticsHubPage extends StatelessWidget {
  const AnalyticsHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AnalyticsCubit()..loadAll(),
      child: const AnalyticsHubView(),
    );
  }
}

class AnalyticsHubView extends StatelessWidget {
  const AnalyticsHubView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsCubit, AnalyticsState>(
      builder: (context, state) {
        return RizenScaffold(
          extendBody: true,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          body: switch (state) {
            AnalyticsLoading() => const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SkeletonChip(width: 160),
                    SizedBox(height: 12),
                    SkeletonChip(width: 160),
                    SizedBox(height: 12),
                    SkeletonChip(width: 160),
                  ],
                ),
              ),
            AnalyticsError(:final message) => Center(
                child: Text(
                  'Error: $message',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            AnalyticsLoaded(
              :final weeklyScore,
              :final habitCompletionRate,
              :final totalFinanceSpent,
              :final quranPagesThisWeek,
              :final streakDays,
            ) =>
              ListView(
                children: [
                  const PageHeader(
                    title: 'Analytics & Growth',
                    subtitle:
                        'Aggregated historical productivity and predictive trends.',
                  ),
                  const SizedBox(height: 20),
                  GlassCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              PhosphorIconsFill.chartBar,
                              color: AppColors.accent,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Overall Score',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        Text(
                          '${weeklyScore.round()} / 100',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(color: AppColors.accent),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  GlassCard(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Habit Completion',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${(habitCompletionRate * 100).toStringAsFixed(0)}%',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Finance Spent',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${totalFinanceSpent.toStringAsFixed(0)} SAR',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  GlassCard(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quran This Week',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$quranPagesThisWeek pages',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Current Streak',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$streakDays days',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  NavGlassTile(
                    title: 'Domain Correlation',
                    subtitle: 'How life pillars influence each other.',
                    icon: PhosphorIconsBold.chartLineUp,
                    iconColor: Color(0xFF60A5FA),
                    onTap: () => context.push(AppRoutes.domainCorrelation),
                  ),
                  const SizedBox(height: 10),
                  NavGlassTile(
                    title: 'Habit Trend Charts',
                    subtitle: 'Temporal tracking of habit velocities.',
                    icon: PhosphorIconsBold.chartLineUp,
                    iconColor: Color(0xFF818CF8),
                    onTap: () => context.push(AppRoutes.habitTrends),
                  ),
                  const SizedBox(height: 10),
                  NavGlassTile(
                    title: 'Growth Index & Burnout Risk',
                    subtitle: 'Predictive indicators showing burnout windows.',
                    icon: PhosphorIconsBold.activity,
                    iconColor: AppColors.warning,
                    onTap: () => context.push(AppRoutes.growthIndex),
                  ),
                  const SizedBox(height: 10),
                  NavGlassTile(
                    title: 'Data Export & Backup',
                    subtitle: 'Privacy-focused data archival tool.',
                    icon: PhosphorIconsBold.export,
                    iconColor: Color(0xFF4ADE80),
                    onTap: () => context.push(AppRoutes.dataExport),
                  ),
                ],
              ),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }
}
