import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.editProfile),
            icon: Icon(PhosphorIconsBold.pencilSimple),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.accent, AppColors.shadow],
                    ),
                    border: Border.all(color: AppColors.glassBorder, width: 2),
                  ),
                  child: Icon(
                    PhosphorIconsFill.user,
                    color: AppColors.textPrimary,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Abdul',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Lvl 12 Disciplined',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          GlassCard(
            child: Column(
              children: [
                _StatRow(
                  label: 'Total Score',
                  value: '12,450',
                  icon: PhosphorIconsBold.trophy,
                  color: AppColors.warning,
                ),
                const Divider(height: 24, color: AppColors.glassBorder),
                _StatRow(
                  label: 'Resilient Streak',
                  value: '18 days',
                  icon: PhosphorIconsFill.fire,
                  color: AppColors.accent,
                ),
                const Divider(height: 24, color: AppColors.glassBorder),
                _StatRow(
                  label: 'Top Domain',
                  value: 'Coding',
                  icon: PhosphorIconsBold.code,
                  color: Color(0xFF60A5FA),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const PageHeader(
            title: 'Achievements',
            subtitle: 'Milestones unlocked through consistency.',
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(6, (i) {
                final colors = [
                  AppColors.warning,
                  AppColors.accent,
                  Color(0xFF60A5FA),
                  Color(0xFF4ADE80),
                  AppColors.shadow,
                  Color(0xFF818CF8),
                ];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colors[i].withValues(alpha: 0.3),
                          AppColors.glassFill,
                        ],
                      ),
                      borderRadius: AppTheme.cardRadius,
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          PhosphorIconsFill.star,
                          color: colors[i],
                          size: 24,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Badge $i',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
