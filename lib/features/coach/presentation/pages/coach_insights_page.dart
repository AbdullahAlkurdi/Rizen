import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';

class CoachInsightsPage extends StatelessWidget {
  const CoachInsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Behavioral Insights',
      subtitle: 'Pattern recognition and personalized correlations.',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(PhosphorIconsBold.arrowClockwise),
        label: Text('Refresh'),
      ),
      body: ListView(
        children: [
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(PhosphorIconsFill.brain, color: AppColors.shadow),
                    const SizedBox(width: 10),
                    Text(
                      'Pattern Recognition',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...List.generate(3, (i) {
                  final patterns = [
                    (
                      'Coding + Prayer sync',
                      'Days with prayer on time show 18% higher coding output.',
                      Color(0xFF60A5FA),
                    ),
                    (
                      'Sleep → Habit Rate',
                      'Waking before 6:30 AM correlates with 92% habit completion.',
                      AppColors.success,
                    ),
                    (
                      'Shadow → Burnout',
                      '3 days of social media after 10 PM precedes sleep drift.',
                      AppColors.accent,
                    ),
                  ][i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 4,
                          height: 36,
                          decoration: BoxDecoration(
                            color: patterns.$3,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                patterns.$1,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                patterns.$2,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GlassCard(
            gradient: LinearGradient(
              colors: [
                AppColors.shadow.withValues(alpha: 0.15),
                AppColors.cardBackground.withValues(alpha: 0.6),
              ],
            ),
            child: Row(
              children: [
                Icon(PhosphorIconsFill.planet, color: AppColors.shadow),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Next: Predictive burnout alert in 2 days based on sleep drift + shadow escalation.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          RizenButton(
            label: 'View Full Report',
            variant: RizenButtonVariant.secondary,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
