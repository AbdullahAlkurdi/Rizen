import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../cubit/spiritual_cubit.dart';

class SpiritualSummaryPage extends StatelessWidget {
  const SpiritualSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpiritualCubit, SpiritualState>(
      builder: (context, state) {
        return RizenScaffold(
          extendBody: true,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          body: switch (state) {
             SpiritualLoading() => const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SkeletonCard(height: 100),
                    SizedBox(height: 12),
                    SkeletonChip(width: 120),
                    SizedBox(height: 12),
                    SkeletonChip(width: 120),
                    SizedBox(height: 12),
                    SkeletonChip(width: 120),
                  ],
                ),
              ),
            SpiritualError(:final message) => Center(
                child: Text(
                  'Error: $message',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            SpiritualSummaryLoaded(
              :final weeklyQuranPages,
              :final adhkarCompletionRate,
              :final consistencyMetric,
              :final quranStreak,
            ) =>
              ListView(
                children: [
                  const PageHeader(
                    title: 'Spiritual Summary',
                    subtitle: 'Weekly spiritual consistency overview.',
                  ),
                  const SizedBox(height: 20),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Consistency Metric',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          consistencyMetric,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quran Streak',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$quranStreak days',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Weekly Pages',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$weeklyQuranPages pages',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Adhkar Completion',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: adhkarCompletionRate,
                          backgroundColor: AppColors.textMuted.withValues(alpha: 0.3),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            adhkarCompletionRate >= 0.8
                                ? AppColors.success
                                : adhkarCompletionRate >= 0.5
                                    ? AppColors.warning
                                    : AppColors.accent,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${(adhkarCompletionRate * 100).toStringAsFixed(0)}% this week',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
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
