import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class HabitsHubPage extends StatelessWidget {
  const HabitsHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      extendBody: true,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      body: ListView(
        children: [
          const PageHeader(
            title: 'Habit Engine',
            subtitle: 'Positive patterns and shadow behavior tracking.',
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.success.withValues(alpha: 0.15),
                  AppColors.glassFill,
                ],
              ),
              borderRadius: AppTheme.cardRadius,
              border: Border.all(
                color: AppColors.success.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  PhosphorIconsFill.trophy,
                  color: AppColors.success,
                  size: 24,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '18-day best streak',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Keep going. Resilience over perfection.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(3, (i) {
            final habits = [
              _HabitItem(
                'Morning Coding',
                'Daily · 30 days',
                PhosphorIconsBold.code,
                const Color(0xFF60A5FA),
                true,
              ),
              _HabitItem(
                'Evenly Read 10 Pages',
                'Daily · 14 days',
                PhosphorIconsBold.bookOpen,
                const Color(0xFF818CF8),
                true,
              ),
              _HabitItem(
                'No Social Media After 10 PM',
                'Daily · 7 days',
                PhosphorIconsBold.clock,
                AppColors.warning,
                false,
              ),
            ][i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                onTap: () => context.push(AppRoutes.habitDetail),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: habits.color.withValues(alpha: 0.15),
                        borderRadius: AppTheme.cardRadius,
                      ),
                      child: Icon(habits.icon, color: habits.color, size: 20),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            habits.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            habits.subtitle,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      habits.completed
                          ? PhosphorIconsFill.checkCircle
                          : PhosphorIconsBold.circle,
                      color: habits.completed
                          ? AppColors.success
                          : AppColors.textMuted,
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: RizenButton(
                  label: 'Add Habit',
                  icon: PhosphorIconsBold.plus,
                  variant: RizenButtonVariant.primary,
                  onPressed: () => context.push(AppRoutes.habitAdd),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: RizenButton(
                  label: 'Add Shadow',
                  icon: PhosphorIconsBold.skull,
                  variant: RizenButtonVariant.secondary,
                  onPressed: () => context.push(AppRoutes.shadowTracker),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          NavGlassTile(
            title: 'Shadow Score',
            subtitle: 'How much energy negative habits have stolen.',
            icon: PhosphorIconsBold.skull,
            iconColor: AppColors.shadow,
            onTap: () => context.push(AppRoutes.shadowScore),
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Reward Store',
            subtitle: 'Unlock real-life pleasures with discipline points.',
            icon: PhosphorIconsBold.gift,
            iconColor: AppColors.accent,
            onTap: () => context.push(AppRoutes.rewardStore),
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Habit Analytics',
            subtitle: 'Trend maps and predictive habit charts.',
            icon: PhosphorIconsBold.chartLineUp,
            iconColor: const Color(0xFF60A5FA),
            onTap: () => context.push(AppRoutes.habitAnalytics),
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Emergency Recovery Mode',
            subtitle: '1-tap workload reduction to prevent burnout.',
            icon: PhosphorIconsBold.firstAid,
            iconColor: AppColors.warning,
            onTap: () => context.push(AppRoutes.emergencyRecovery),
          ),
        ],
      ),
    );
  }
}

class _HabitItem {
  const _HabitItem(
    this.title,
    this.subtitle,
    this.icon,
    this.color,
    this.completed,
  );

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool completed;
}
