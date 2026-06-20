import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Notifications'),
        actions: [TextButton(onPressed: () {}, child: const Text('Reset'))],
      ),
      body: ListView(
        children: [
          GlassCard(
            child: Row(
              children: [
                Icon(PhosphorIconsBold.bell, color: AppColors.accent),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enable Notifications',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Master toggle for all alerts.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: true,
                  activeThumbColor: AppColors.accent,
                  onChanged: (v) {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(4, (i) {
            final settings = [
              (
                'Routine Reminders',
                true,
                Color(0xFF60A5FA),
                PhosphorIconsBold.clockCountdown,
              ),
              (
                'AI Coach Briefings',
                true,
                AppColors.shadow,
                PhosphorIconsBold.robot,
              ),
              (
                'Prayer Time Alerts',
                true,
                AppColors.warning,
                PhosphorIconsBold.moonStars,
              ),
              (
                'Shadow Habit Warnings',
                false,
                AppColors.accent,
                PhosphorIconsBold.skull,
              ),
            ][i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: settings.$3.withValues(alpha: 0.15),
                        borderRadius: AppTheme.cardRadius,
                      ),
                      child: Icon(settings.$4, color: settings.$3, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        settings.$1,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Switch(
                      value: settings.$2,
                      activeThumbColor: AppColors.accent,
                      onChanged: (v) {},
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
