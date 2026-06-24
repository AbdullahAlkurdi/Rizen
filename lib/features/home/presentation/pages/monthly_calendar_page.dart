import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../cubit/home_cubit.dart';

class MonthlyCalendarPage extends StatelessWidget {
  const MonthlyCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final completedDays = state is HomeLoaded
            ? state.completedDays
            : <int>{};
        final now = DateTime.now();
        final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
        final firstDayOfWeek = DateTime(now.year, now.month, 1).weekday;
        final offset = firstDayOfWeek % 7;

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
                      '${_monthName(now.month)} ${now.year}',
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
                      (d) => Text(
                        d,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
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
                itemCount: daysInMonth + offset,
                itemBuilder: (context, index) {
                  if (index < offset) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.glassFill,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  }
                  final day = index - offset + 1;
                  final completed = completedDays.contains(day);
                  final isToday = day == now.day;

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
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
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
      },
    );
  }

  String _monthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
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
