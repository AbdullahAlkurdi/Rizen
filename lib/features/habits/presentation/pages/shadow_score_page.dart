import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';

class ShadowScorePage extends StatelessWidget {
  const ShadowScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Shadow Score',
      subtitle: 'Energy and focus lost to negative habits.',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(PhosphorIconsBold.plus),
        label: Text('Log Shadow Event'),
      ),
      body: ListView(
        children: [
          GlassCard(
            gradient: LinearGradient(
              colors: [
                AppColors.shadow.withValues(alpha: 0.2),
                AppColors.cardBackground.withValues(alpha: 0.6),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(PhosphorIconsFill.skull, color: AppColors.shadow),
                    const SizedBox(width: 10),
                    Text(
                      'Current Shadow Score',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '42',
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium?.copyWith(color: AppColors.shadow),
                ),
                const SizedBox(height: 4),
                Text(
                  'Today\'s score · 12 pts above weekly avg',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text('Pillar Impact', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ...List.generate(3, (i) {
            final impacts = [
              ('Coding', '-45 mins', Color(0xFF60A5FA), 0.45),
              ('Study', '-20 mins', Color(0xFF818CF8), 0.20),
              ('Spiritual', '-15 mins', AppColors.warning, 0.15),
            ][i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                child: Row(
                  children: [
                    Icon(
                      PhosphorIconsBold.warning,
                      color: impacts.$3,
                      size: 18,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        impacts.$1,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Text(
                      impacts.$2,
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium?.copyWith(color: impacts.$3),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 40,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.glassFill,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: impacts.$4,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: impacts.$3,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 20),
          RizenButton(
            label: 'View Habit Analytics',
            variant: RizenButtonVariant.secondary,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
