import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../core/widgets/rizen_button.dart';

class EmergencyRecoveryPage extends StatelessWidget {
  const EmergencyRecoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Emergency Recovery Mode'),
      ),
      body: ListView(
        children: [
          const PageHeader(
            title: 'Burnout Prevention',
            subtitle:
                'Automatically shrink your daily payload while preserving your streak.',
          ),
          const SizedBox(height: 20),
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
                Row(
                  children: [
                    Icon(PhosphorIconsFill.firstAid, color: AppColors.warning),
                    const SizedBox(width: 10),
                    Text(
                      'Current Status',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Bed Resistance Metric: 68',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Rizen has already downgraded today\'s payload to a bare-minimum survival baseline. No punitive alerts sent.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Survival Baseline',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          ...List.generate(3, (i) {
            final items = [
              ('Read 1 page', 'Instead of 30 pages', AppColors.success, true),
              ('Walk 10 mins', 'Instead of 5km run', AppColors.success, true),
              (
                'One focused Pomodoro',
                'Instead of 3-hour deep work',
                AppColors.success,
                true,
              ),
            ][i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                child: Row(
                  children: [
                    Icon(
                      PhosphorIconsFill.checkCircle,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items.$1,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            items.$2,
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
          const SizedBox(height: 24),
          RizenButton(
            label: 'Exit Recovery Mode',
            icon: PhosphorIconsBold.arrowRight,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Recovery Mode deactivated. Full routine restored.',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          NavGlassTile(
            title: 'Reward Store',
            subtitle: 'Spend discipline points on unlocked rewards.',
            icon: PhosphorIconsBold.gift,
            iconColor: AppColors.accent,
            onTap: () => context.push(AppRoutes.rewardStore),
          ),
        ],
      ),
    );
  }
}
