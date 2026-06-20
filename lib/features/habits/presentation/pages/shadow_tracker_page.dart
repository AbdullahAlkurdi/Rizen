import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';

class ShadowTrackerPage extends StatelessWidget {
  const ShadowTrackerPage({super.key});

  static final _shadows = [
    _ShadowHabit('Doom Scrolling', '47m today', 0.4, AppColors.shadow),
    _ShadowHabit('Late-night Gaming', '28m today', 0.25, Color(0xFF9333EA)),
    _ShadowHabit('Procrastination', '15m today', 0.15, AppColors.accent),
  ];

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Shadow Tracker',
      subtitle: 'Monitor behavioral avoidance patterns.',
      body: ListView(
        children: [
          const PageHeader(
            title: 'Shadow Habits',
            subtitle: 'Track negative patterns and their cost.',
          ),
          const SizedBox(height: 20),
          ..._shadows.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                onTap: () {},
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: s.color.withValues(alpha: 0.15),
                        borderRadius: AppTheme.cardRadius,
                      ),
                      child: Icon(
                        PhosphorIconsBold.skull,
                        color: s.color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            s.time,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.glassFill,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: s.impact,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: s.color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShadowHabit {
  const _ShadowHabit(this.title, this.time, this.impact, this.color);
  final String title;
  final String time;
  final double impact;
  final Color color;
}
