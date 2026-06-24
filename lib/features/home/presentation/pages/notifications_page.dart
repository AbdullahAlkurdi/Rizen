import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../data/models/daily_score_model.dart';
import '../cubit/home_cubit.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final notifications = state is HomeLoaded
            ? state.notifications
            : <NotificationItem>[];

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
                  FilterChip(
                    label: const Text('Important'),
                    onSelected: (_) {},
                  ),
                  FilterChip(label: const Text('AI Coach'), onSelected: (_) {}),
                  FilterChip(
                    label: const Text('Spiritual'),
                    onSelected: (_) {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ...notifications.map((notification) {
                final icon = _iconForCategory(notification.category);
                final color = _colorForCategory(notification.category);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GlassCard(
                    borderColor: notification.isImportant
                        ? color.withValues(alpha: 0.5)
                        : null,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.15),
                            borderRadius: AppTheme.cardRadius,
                          ),
                          child: Icon(icon, color: color, size: 20),
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
                                      notification.title,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                  ),
                                  Text(
                                    _timeAgo(notification.timestamp),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notification.body,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  IconData _iconForCategory(NotificationCategory category) {
    switch (category) {
      case NotificationCategory.system:
        return PhosphorIconsBold.gear;
      case NotificationCategory.aiCoach:
        return PhosphorIconsBold.robot;
      case NotificationCategory.spiritual:
        return PhosphorIconsBold.moonStars;
      case NotificationCategory.habit:
        return PhosphorIconsBold.checkCircle;
    }
  }

  Color _colorForCategory(NotificationCategory category) {
    switch (category) {
      case NotificationCategory.system:
        return AppColors.success;
      case NotificationCategory.aiCoach:
        return Color(0xFF9333EA);
      case NotificationCategory.spiritual:
        return AppColors.warning;
      case NotificationCategory.habit:
        return AppColors.accent;
    }
  }

  String _timeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${timestamp.day}/${timestamp.month}';
  }
}
