import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../cubit/habits_cubit.dart';

class ShadowTrackerPage extends StatelessWidget {
  const ShadowTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HabitsCubit()..loadHabits(),
      child: const ShadowTrackerView(),
    );
  }
}

class ShadowTrackerView extends StatelessWidget {
  const ShadowTrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsCubit, HabitsState>(
      builder: (context, state) {
        return FeatureScaffold(
          title: 'Shadow Tracker',
          subtitle: 'Monitor behavioral avoidance patterns.',
          body: ListView(
            children: [
              const PageHeader(
                title: 'Shadow Habits',
                subtitle: 'Track negative patterns and their cost.',
              ),
              const SizedBox(height: 20),
              if (state is HabitsLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (state is HabitsError)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                )
              else if (state is HabitsLoaded)
                ...state.shadow.map((habit) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GlassCard(
                      onTap: () {},
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.shadow.withValues(alpha: 0.15),
                              borderRadius: AppTheme.cardRadius,
                            ),
                            child: Icon(
                              PhosphorIconsBold.skull,
                              color: AppColors.shadow,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  habit.name,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  '${state.shadowScore} logged today',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 8,
                            decoration: BoxDecoration(
                              color: AppColors.glassFill,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: FractionallySizedBox(
                              widthFactor: (state.shadowScore / 10).clamp(0.0, 1.0),
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.shadow,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              const SizedBox(height: 20),
              RizenButton(
                label: 'Log Shadow Event',
                icon: PhosphorIconsBold.plus,
                onPressed: () => _showLogDialog(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogDialog(BuildContext context) {
    final habits = context.read<HabitsCubit>().state;
    if (habits is! HabitsLoaded) return;

    final shadowHabits = habits.shadow;
    if (shadowHabits.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Shadow Event'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: shadowHabits
              .map((h) => ListTile(
                    title: Text(h.name),
                    onTap: () {
                      context.read<HabitsCubit>().checkIn(habitId: h.id, note: 'Shadow');
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}
