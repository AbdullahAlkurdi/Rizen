import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';

class CoachSuggestionsPage extends StatelessWidget {
  const CoachSuggestionsPage({super.key});

  static const _suggestions = [
    _Suggestion(
      'Shift coding block to 6:30 AM',
      'Your focus score peaks before 8 AM.',
      PhosphorIconsBold.clock,
      Color(0xFF60A5FA),
      false,
    ),
    _Suggestion(
      'Move workout after Dhuhr',
      'Matches energy pattern.',
      PhosphorIconsBold.barbell,
      Color(0xFF4ADE80),
      false,
    ),
    _Suggestion(
      'Enable evening Recovery Mode',
      'Sleep drift detected.',
      PhosphorIconsBold.firstAid,
      AppColors.warning,
      false,
    ),
    _Suggestion(
      'Add Quran reading before bed',
      'Spiritual domain at 90% — small push recommended.',
      PhosphorIconsBold.moonStars,
      AppColors.warning,
      false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'AI Suggestions',
      subtitle: 'Actionable course corrections for today.',
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
                    Icon(PhosphorIconsFill.robot, color: AppColors.accent),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '4 suggestions to optimize your day.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ..._suggestions.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                onTap: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: s.color.withValues(alpha: 0.15),
                        borderRadius: AppTheme.cardRadius,
                      ),
                      child: Icon(s.icon, color: s.color, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.title,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            s.reason,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      PhosphorIconsBold.arrowRight,
                      color: AppColors.textMuted,
                      size: 16,
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

class _Suggestion {
  const _Suggestion(
    this.title,
    this.reason,
    this.icon,
    this.color,
    this.applied,
  );
  final String title;
  final String reason;
  final IconData icon;
  final Color color;
  final bool applied;
}
