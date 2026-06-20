import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  static const _alerts = [
    _Alert(
      title: 'Asr in 15 minutes',
      body: 'Coding block shifts to after Maghrib automatically.',
      time: '2h ago',
      icon: PhosphorIconsBold.moonStars,
      color: AppColors.warning,
      isImportant: true,
    ),
    _Alert(
      title: 'Burnout risk detected',
      body: 'Sleep drift + habit deceleration over 3 days.',
      time: '5h ago',
      icon: PhosphorIconsBold.firstAid,
      color: AppColors.accent,
      isImportant: true,
    ),
    _Alert(
      title: 'Morning briefing ready',
      body: 'Your AI Coach prepared today\'s adaptive roadmap.',
      time: '8h ago',
      icon: PhosphorIconsBold.robot,
      color: Color(0xFF9333EA),
      isImportant: false,
    ),
    _Alert(
      title: 'Shadow habit warning',
      body: 'Doom scrolling exceeded 45 minutes today.',
      time: 'Yesterday',
      icon: PhosphorIconsBold.skull,
      color: AppColors.shadow,
      isImportant: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Notifications',
      subtitle: 'Filtered systemic logs and contextual alerts.',
      actions: [
        TextButton(onPressed: () {}, child: const Text('Mark all read')),
      ],
      body: ListView(
        children: [
          Wrap(
            spacing: 8,
            children: [
              FilterChip(
                label: const Text('All'),
                selected: true,
                onSelected: (_) {},
                selectedColor: AppColors.accent.withValues(alpha: 0.2),
              ),
              FilterChip(label: const Text('Important'), onSelected: (_) {}),
              FilterChip(label: const Text('AI Coach'), onSelected: (_) {}),
              FilterChip(label: const Text('Spiritual'), onSelected: (_) {}),
            ],
          ),
          const SizedBox(height: 20),
          ..._alerts.map(
            (alert) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                borderColor: alert.isImportant
                    ? alert.color.withValues(alpha: 0.5)
                    : null,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: alert.color.withValues(alpha: 0.15),
                        borderRadius: AppTheme.cardRadius,
                      ),
                      child: Icon(alert.icon, color: alert.color, size: 20),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  alert.title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                              ),
                              Text(
                                alert.time,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            alert.body,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
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

class _Alert {
  const _Alert({
    required this.title,
    required this.body,
    required this.time,
    required this.icon,
    required this.color,
    required this.isImportant,
  });

  final String title;
  final String body;
  final String time;
  final IconData icon;
  final Color color;
  final bool isImportant;
}
