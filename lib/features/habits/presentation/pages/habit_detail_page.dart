import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class HabitDetailPage extends StatelessWidget {
  const HabitDetailPage({super.key});

  static const _matrix = [
    _DayEntry('Mon', true),
    _DayEntry('Tue', true),
    _DayEntry('Wed', true),
    _DayEntry('Thu', false),
    _DayEntry('Fri', true),
    _DayEntry('Sat', true),
    _DayEntry('Sun', true),
  ];

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Habit Detail'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(PhosphorIconsBold.pencilSimple),
          ),
        ],
      ),
      body: ListView(
        children: [
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Color(0xFF60A5FA).withValues(alpha: 0.15),
                        borderRadius: AppTheme.cardRadius,
                      ),
                      child: Icon(
                        PhosphorIconsBold.code,
                        color: Color(0xFF60A5FA),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Morning Coding',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            'Daily · 30-day streak',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _matrix.map((d) {
                    return Column(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: d.completed
                                ? AppColors.success.withValues(alpha: 0.2)
                                : AppColors.glassFill,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: d.completed
                                  ? AppColors.success.withValues(alpha: 0.4)
                                  : AppColors.glassBorder,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              d.day,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: d.completed
                                        ? AppColors.success
                                        : null,
                                    fontWeight: d.completed
                                        ? FontWeight.w700
                                        : null,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Streak Matrix', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          GlassCard(
            child: Column(
              children: List.generate(4, (week) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: List.generate(7, (day) {
                      final complete = (week * 7 + day) % 4 != 0;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Container(
                            height: 28,
                            decoration: BoxDecoration(
                              color: complete
                                  ? AppColors.success.withValues(alpha: 0.3)
                                  : AppColors.glassFill,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
          NavGlassTile(
            title: 'Habit Analytics',
            subtitle: 'Detailed trend analysis.',
            icon: PhosphorIconsBold.chartLineUp,
            iconColor: Color(0xFF60A5FA),
            onTap: () => context.push(AppRoutes.habitAnalytics),
          ),
        ],
      ),
    );
  }
}

class _DayEntry {
  const _DayEntry(this.day, this.completed);
  final String day;
  final bool completed;
}
