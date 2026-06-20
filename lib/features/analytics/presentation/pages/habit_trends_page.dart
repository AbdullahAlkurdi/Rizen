import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';

class HabitTrendsPage extends StatelessWidget {
  const HabitTrendsPage({super.key});

  static const _trends = [62, 75, 68, 82, 71, 88, 76];

  @override
  Widget build(BuildContext context) {
    final max = _trends.reduce((a, b) => a > b ? a : b).toDouble();
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
                  '7-Day Velocity',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 180,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(_trends.length, (i) {
                      final h = _trends[i] / max;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${_trends[i]}%',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              const SizedBox(height: 4),
                              Container(
                                height: 120 * h,
                                decoration: BoxDecoration(
                                  color: i == 5
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
                              Text(
                                ['M', 'T', 'W', 'T', 'F', 'S', 'S'][i],
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
  }
}
