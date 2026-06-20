import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';

class CoachMicroGoalsPage extends StatelessWidget {
  const CoachMicroGoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Micro-Goal Adjustment',
      subtitle: 'Dynamic goal shifting based on real-time patterns.',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(PhosphorIconsBold.arrowClockwise),
        label: Text('Recalculate'),
      ),
      body: ListView(
        children: [
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(PhosphorIconsFill.target, color: AppColors.accent),
                    const SizedBox(width: 10),
                    Text(
                      'Current Targets',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...List.generate(3, (i) {
                  final goals = [
                    ('Coding', '12h / week', 'On track'),
                    ('Study', '6h / week', 'Behind by 1h'),
                    ('Sports', '4.5h / week', 'On track'),
                  ][i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                goals.$1,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                goals.$2,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: goals.$3.startsWith('Behind')
                                ? AppColors.warning.withValues(alpha: 0.15)
                                : AppColors.success.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            goals.$3,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: goals.$3.startsWith('Behind')
                                      ? AppColors.warning
                                      : AppColors.success,
                                ),
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
          RizenButton(
            label: 'Apply AI Adjustments',
            icon: PhosphorIconsBold.check,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
