import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class RoutineDetailPage extends StatelessWidget {
  const RoutineDetailPage({super.key});

  static const _tasks = [
    _TaskItem(
      'Wudu & Fajr Prayer',
      '06:00 - 06:20',
      PhosphorIconsBold.moonStars,
      AppColors.warning,
      true,
    ),
    _TaskItem(
      'Morning Reflection',
      '06:20 - 06:35',
      PhosphorIconsBold.bookOpen,
      Color(0xFF60A5FA),
      true,
    ),
    _TaskItem(
      'Deep Coding Session',
      '06:35 - 07:45',
      PhosphorIconsBold.code,
      Color(0xFF818CF8),
      true,
    ),
    _TaskItem(
      'Breakfast & Planning',
      '07:45 - 08:15',
      PhosphorIconsBold.bowlFood,
      Color(0xFFFB923C),
      false,
    ),
    _TaskItem(
      'Professional Focus Block',
      '08:15 - 11:45',
      PhosphorIconsBold.briefcase,
      Color(0xFF38BDF8),
      true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final completedCount = _tasks.where((t) => t.completed).length;

    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Morning Power Routine'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(PhosphorIconsBold.pencilSimple),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(PhosphorIconsBold.dotsThreeVertical),
          ),
        ],
      ),
      body: ListView(
        children: [
          GlassCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progress',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$completedCount / ${_tasks.length} tasks',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Est. Duration',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '5h 45m',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: completedCount / _tasks.length,
            backgroundColor: AppColors.glassFill,
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(4),
            minHeight: 8,
          ),
          const SizedBox(height: 24),
          ..._tasks.map((task) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                onTap: () => context.push(AppRoutes.routineTimeBlocks),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: task.completed
                            ? AppColors.success.withValues(alpha: 0.2)
                            : task.color.withValues(alpha: 0.15),
                        borderRadius: AppTheme.cardRadius,
                      ),
                      child: Icon(
                        task.completed
                            ? PhosphorIconsFill.checkCircle
                            : task.icon,
                        color: task.completed ? AppColors.success : task.color,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  decoration: task.completed
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: task.completed
                                      ? AppColors.textMuted
                                      : null,
                                ),
                          ),
                          Text(
                            task.time,
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
            );
          }),
          const SizedBox(height: 16),
          NavGlassTile(
            title: 'Open Visual Editor',
            subtitle: 'Drag-and-drop time-block layout.',
            icon: PhosphorIconsBold.listDashes,
            iconColor: Color(0xFF818CF8),
            onTap: () => context.push(AppRoutes.routineTimeBlocks),
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'AI Suggestions for this Routine',
            subtitle: 'Gemini optimization recommendations.',
            icon: PhosphorIconsBold.robot,
            iconColor: AppColors.shadow,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _TaskItem {
  const _TaskItem(this.title, this.time, this.icon, this.color, this.completed);

  final String title;
  final String time;
  final IconData icon;
  final Color color;
  final bool completed;
}
