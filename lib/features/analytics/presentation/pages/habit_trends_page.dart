import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../cubit/analytics_cubit.dart';

class HabitTrendsPage extends StatelessWidget {
  const HabitTrendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsCubit, AnalyticsState>(
      builder: (context, state) {
        final trendData = state is AnalyticsLoaded ? state.trendData : <dynamic>[];
        final scores = trendData.map((d) => (d as dynamic).totalScore as int).toList();
        final max = scores.isNotEmpty ? scores.reduce((a, b) => a > b ? a : b).toDouble() : 100.0;

        return FeatureScaffold(
          title: 'Habit Trends',
          subtitle: 'Temporal tracking of habit velocities.',
          body: ListView(
            children: [
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '30-Day Velocity',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    if (scores.isEmpty)
                      const Center(child: Text('Load analytics to view trends.'))
                    else
                      SizedBox(
                        height: 180,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(scores.length, (i) {
                            final h = scores[i] / max;
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${scores[i]}',
                                      style: Theme.of(context).textTheme.labelSmall,
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      height: 120 * h,
                                      decoration: BoxDecoration(
                                        color: i == scores.length - 1
                                            ? AppColors.accent
                                            : AppColors.accent.withValues(
                                                alpha: 0.45,
                                              ),
                                        borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(6),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    if (i % 5 == 0)
                                      Text(
                                        'D${i + 1}',
                                        style: Theme.of(context).textTheme.labelSmall,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
