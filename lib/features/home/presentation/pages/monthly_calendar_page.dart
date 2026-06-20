import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';

class MonthlyCalendarPage extends StatelessWidget {
  const MonthlyCalendarPage({super.key});

  static const _daysInMonth = 30;
  static const _completedDays = {
    1,
    2,
    3,
    5,
    6,
    8,
    9,
    10,
    12,
    14,
    15,
    17,
    18,
    20,
    22,
    24,
    25,
    27,
    28,
  };

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Monthly Calendar',
      subtitle: 'Habit consistency and streak mapping.',
      body: ListView(
        children: [
          GlassCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(PhosphorIconsBold.caretLeft),
                ),
                Text(
                  'June 2026',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(PhosphorIconsBold.caretRight),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                .map(
                  (d) => Text(d, style: Theme.of(context).textTheme.labelSmall),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: _daysInMonth,
            itemBuilder: (context, index) {
              final day = index + 1;
              final completed = _completedDays.contains(day);
              final isToday = day == 20;

              return Container(
                decoration: BoxDecoration(
                  color: completed
                      ? AppColors.success.withValues(alpha: 0.2)
                      : AppColors.glassFill,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isToday
                        ? AppColors.accent
                        : completed
                        ? AppColors.success.withValues(alpha: 0.4)
                        : AppColors.glassBorder,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$day',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: isToday ? AppColors.accent : null,
                      fontWeight: isToday ? FontWeight.w700 : null,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          GlassCard(
            child: Row(
              children: [
                _LegendDot(color: AppColors.success, label: 'Completed'),
                const SizedBox(width: 20),
                _LegendDot(color: AppColors.glassFill, label: 'Missed'),
                const SizedBox(width: 20),
                _LegendDot(color: AppColors.accent, label: 'Today'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.glassBorder),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
