import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';

class SleepAnalyticsPage extends StatelessWidget {
  const SleepAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Sleep & Discipline',
      body: ListView(
        children: [
          const PageHeader(
            title: 'Passive Tracking',
            subtitle:
                'First phone unlock, wake timestamps, and Bed Resistance Metric.',
          ),
          const SizedBox(height: 20),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(PhosphorIconsBold.alarm, color: AppColors.accent),
                    const SizedBox(width: 10),
                    Text(
                      'Today\'s Wake Event',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _WakeStat(
                        label: 'Target',
                        value: '5:30 AM',
                        color: AppColors.success,
                      ),
                    ),
                    Expanded(
                      child: _WakeStat(
                        label: 'Actual',
                        value: '6:45 AM',
                        color: AppColors.warning,
                      ),
                    ),
                    Expanded(
                      child: _WakeStat(
                        label: 'Delay',
                        value: '+75m',
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          GlassCard(
            gradient: LinearGradient(
              colors: [
                AppColors.warning.withValues(alpha: 0.15),
                AppColors.cardBackground.withValues(alpha: 0.7),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bed Resistance Metric: 68',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Rizen downgraded today\'s payload to prevent cognitive fatigue — no punitive alerts sent.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: 0.68,
                  backgroundColor: AppColors.glassFill,
                  color: AppColors.warning,
                  borderRadius: BorderRadius.circular(4),
                  minHeight: 8,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '7-Day Wake Pattern',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          GlassCard(
            child: SizedBox(
              height: 140,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(7, (index) {
                  final heights = [0.3, 0.5, 0.4, 0.7, 0.6, 0.85, 0.75];
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 100 * heights[index],
                            decoration: BoxDecoration(
                              color: index == 5
                                  ? AppColors.accent
                                  : AppColors.accent.withValues(alpha: 0.4),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(6),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WakeStat extends StatelessWidget {
  const _WakeStat({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: color),
        ),
      ],
    );
  }
}
