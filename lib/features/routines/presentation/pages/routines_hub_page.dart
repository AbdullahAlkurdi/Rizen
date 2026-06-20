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

class RoutinesHubPage extends StatelessWidget {
  const RoutinesHubPage({super.key});

  static const _routines = [
    _RoutineItem(
      title: 'Morning Power Routine',
      blocks: 4,
      duration: '1h 45m',
      streak: 12,
      color: Color(0xFF60A5FA),
      icon: PhosphorIconsFill.sun,
    ),
    _RoutineItem(
      title: 'Deep Focus Workday',
      blocks: 6,
      duration: '3h 30m',
      streak: 8,
      color: Color(0xFF818CF8),
      icon: PhosphorIconsFill.briefcase,
    ),
    _RoutineItem(
      title: 'Evening Wind-down',
      blocks: 3,
      duration: '1h 15m',
      streak: 21,
      color: Color(0xFFFBBF24),
      icon: PhosphorIconsFill.moonStars,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      extendBody: true,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      body: ListView(
        children: [
          const PageHeader(
            title: 'Routines',
            subtitle: 'Dynamic schedules and adaptive time-blocking.',
          ),
          const SizedBox(height: 20),
          ..._routines.map(
            (routine) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GlassCard(
                onTap: () => context.push(AppRoutes.routineDetail),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: routine.color.withValues(alpha: 0.15),
                        borderRadius: AppTheme.cardRadius,
                      ),
                      child: Icon(routine.icon, color: routine.color, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            routine.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${routine.blocks} blocks · ${routine.duration} · ${routine.streak}d streak',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      PhosphorIconsBold.caretRight,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          RizenButton(
            label: 'Create New Routine',
            icon: PhosphorIconsBold.plus,
            onPressed: () => context.push(AppRoutes.routineCreate),
          ),
          const SizedBox(height: 12),
          NavGlassTile(
            title: 'AI Routine Generator',
            subtitle: 'Let Gemini build your schedule from a prompt.',
            icon: PhosphorIconsBold.magicWand,
            iconColor: AppColors.shadow,
            onTap: () => context.push(AppRoutes.routineAiGenerator),
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Routine Templates',
            subtitle: 'Preset configurations for common archetypes.',
            icon: PhosphorIconsBold.files,
            iconColor: Color(0xFF60A5FA),
            onTap: () => context.push(AppRoutes.routineTemplates),
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Historical Routine Log',
            subtitle: 'Review past routine iterations.',
            icon: PhosphorIconsBold.clockCounterClockwise,
            iconColor: Color(0xFF4ADE80),
            onTap: () => context.push(AppRoutes.routineHistory),
          ),
        ],
      ),
    );
  }
}

class _RoutineItem {
  const _RoutineItem({
    required this.title,
    required this.blocks,
    required this.duration,
    required this.streak,
    required this.color,
    required this.icon,
  });

  final String title;
  final int blocks;
  final String duration;
  final int streak;
  final Color color;
  final IconData icon;
}
