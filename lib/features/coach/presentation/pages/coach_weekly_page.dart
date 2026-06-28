import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../../todo/domain/usecases/get_missed_items_usecase.dart';
import '../../../todo/domain/repositories/todo_repository_interface.dart';
import '../cubit/coach_cubit.dart';
import '../../data/models/coach_message_model.dart';

class WeeklyTodoDiscipline {
  WeeklyTodoDiscipline({
    required this.weeklyAvgPct,
    required this.habitBreakdown,
    required this.topMissedItems,
    required this.trend,
  });

  final double weeklyAvgPct;
  final List<HabitTodoBreakdown> habitBreakdown;
  final List<TopMissedItem> topMissedItems;
  final Trend trend;
}

class HabitTodoBreakdown {
  HabitTodoBreakdown({
    required this.habitId,
    required this.avgCompletionPct,
    required this.dailyPcts,
  });

  final String habitId;
  final double avgCompletionPct;
  final List<double> dailyPcts;
}

class TopMissedItem {
  TopMissedItem({
    required this.title,
    required this.missCount,
  });

  final String title;
  final int missCount;
}

enum Trend { improving, declining, stable }

class CoachWeeklyPage extends StatefulWidget {
  const CoachWeeklyPage({super.key});

  @override
  State<CoachWeeklyPage> createState() => _CoachWeeklyPageState();
}

class _CoachWeeklyPageState extends State<CoachWeeklyPage> {
  WeeklyTodoDiscipline? _weeklyDiscipline;
  bool _isLoadingTodo = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadWeeklyTodoData();
    });
  }

  Future<void> _loadWeeklyTodoData() async {
    setState(() => _isLoadingTodo = true);
    try {
      final todoRepo = context.read<TodoRepositoryInterface>();
      final missedItemsUseCase = context.read<GetMissedItemsUseCase>();

      final now = DateTime.now();
      final dailyPctByHabit = <String, List<double>>{};

      for (int i = 0; i < 7; i++) {
        final date = now.subtract(Duration(days: i));
        final lists = await todoRepo.getTodoListsByDate(date);
        for (final list in lists) {
          dailyPctByHabit.putIfAbsent(list.parentId, () => []).add(list.completionPct);
        }
      }

      final habitBreakdown = dailyPctByHabit.entries.map((e) {
        final pcts = e.value;
        final avg = pcts.isEmpty ? 0.0 : pcts.reduce((a, b) => a + b) / pcts.length;
        return HabitTodoBreakdown(
          habitId: e.key,
          avgCompletionPct: avg,
          dailyPcts: pcts,
        );
      }).toList()
        ..sort((a, b) => a.avgCompletionPct.compareTo(b.avgCompletionPct));

      final allMissed = await missedItemsUseCase.call(null, 7);
      final topMissed = allMissed
          .take(3)
          .map((i) => TopMissedItem(title: i.title, missCount: i.missCount))
          .toList();

      double thisWeekAvg = 0.0;
      int totalPcts = 0;
      for (var entry in dailyPctByHabit.entries) {
        for (var pct in entry.value) {
          thisWeekAvg += pct;
          totalPcts++;
        }
      }
      thisWeekAvg = totalPcts == 0 ? 0.0 : thisWeekAvg / totalPcts;

      Trend trend = Trend.stable;

      setState(() {
        _weeklyDiscipline = WeeklyTodoDiscipline(
          weeklyAvgPct: thisWeekAvg,
          habitBreakdown: habitBreakdown,
          topMissedItems: topMissed,
          trend: trend,
        );
        _isLoadingTodo = false;
      });
    } catch (_) {
      setState(() => _isLoadingTodo = false);
    }
  }

  Color _getPctColor(double pct) {
    if (pct >= 80) return const Color(0xFF4CAF50);
    if (pct >= 50) return const Color(0xFFFFB300);
    return const Color(0xFFE94560);
  }

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Weekly AI Synthesis',
      subtitle: 'End-of-week master psychological report.',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (context.mounted) {
            context.read<CoachCubit>().generateWeeklySynthesis();
          }
        },
        icon: Icon(PhosphorIconsBold.download),
        label: const Text('Export PDF'),
      ),
      body: BlocBuilder<CoachCubit, CoachState>(
        builder: (context, state) {
          List<CoachMessage> messages;
          if (state is CoachLoaded) {
            messages = state.messages;
          } else if (state is CoachError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(PhosphorIconsBold.warningCircle, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(state.message, textAlign: TextAlign.center),
                ],
              ),
            );
          } else {
            messages = const <CoachMessage>[];
          }

          return ListView(
            children: [
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(PhosphorIconsFill.robot, color: AppColors.accent),
                        const SizedBox(width: 10),
                        Text(
                          'Week of June 14 – June 20',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Discipline Score: 76 / 100',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    if (messages.isNotEmpty)
                      Text(
                        messages.last.content,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    else
                      Text(
                        'Up from 68 last week. Momentum building in Coding and Spiritual pillars.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (_isLoadingTodo)
                _buildTodoLoadingState()
              else if (_weeklyDiscipline != null)
                _buildChecklistDisciplineSection(context)
              else
                const SizedBox.shrink(),
              const SizedBox(height: 20),
              Text('Key Insights', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              ...List.generate(4, (i) {
                final insights = [
                  (
                    'Coding peaked mid-week',
                    'Wednesday block was highest quality.',
                  ),
                  (
                    'Saturday dip pattern',
                    'Consistent recovery need — consider lighter Saturday routine.',
                  ),
                  (
                    'Shadow score improving',
                    '-8% vs last week. Doom scrolling decreased.',
                  ),
                  ('Sleep window stabilizing', 'Average wake shifted 15m earlier.'),
                ][i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GlassCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          PhosphorIconsBold.sparkle,
                          color: AppColors.accent,
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                insights.$1,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                insights.$2,
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
              const SizedBox(height: 20),
              RizenButton(
                label: 'Schedule Review Session',
                variant: RizenButtonVariant.secondary,
                onPressed: () {},
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTodoLoadingState() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Checklist Discipline',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const SkeletonLine(height: 40),
          const SizedBox(height: 16),
          ...List.generate(3, (i) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonLine(height: 16),
                const SizedBox(height: 8),
                const SkeletonLine(height: 16),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildChecklistDisciplineSection(BuildContext context) {
    final discipline = _weeklyDiscipline!;
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Checklist Discipline',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              '${discipline.weeklyAvgPct.toStringAsFixed(0)}%',
              style: TextStyle(
                color: _getPctColor(discipline.weeklyAvgPct),
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              '7-day average completion',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                  ),
            ),
          ),
          const SizedBox(height: 20),
          ...discipline.habitBreakdown.map((habit) => _buildHabitBreakdownRow(context, habit)),
          if (discipline.topMissedItems.isNotEmpty) ...[
            const SizedBox(height: 20),
            _buildTopMissedSection(context, discipline),
          ],
          const SizedBox(height: 20),
          _buildTrendIndicator(context, discipline.trend),
        ],
      ),
    );
  }

  Widget _buildHabitBreakdownRow(BuildContext context, HabitTodoBreakdown habit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                habit.habitId,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
              Text(
                '${habit.avgCompletionPct.toStringAsFixed(0)}%',
                style: TextStyle(
                  color: _getPctColor(habit.avgCompletionPct),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: habit.dailyPcts.map((pct) {
              return Container(
                width: 8,
                height: 30 * (pct / 100).clamp(0.0, 1.0) + 4,
                decoration: BoxDecoration(
                  color: _getPctColor(pct),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopMissedSection(BuildContext context, WeeklyTodoDiscipline discipline) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(PhosphorIconsBold.trendDown, color: const Color(0xFFE94560), size: 18),
            const SizedBox(width: 6),
            Text(
              'Most skipped this week',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFFE94560),
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...discipline.topMissedItems.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            '${item.title} — skipped ${item.missCount}\u00D7',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        )),
      ],
    );
  }

  Widget _buildTrendIndicator(BuildContext context, Trend trend) {
    IconData icon;
    Color color;
    String text;

    switch (trend) {
      case Trend.improving:
        icon = PhosphorIconsBold.trendUp;
        color = const Color(0xFF4CAF50);
        text = 'Up from last week';
      case Trend.declining:
        icon = PhosphorIconsBold.trendDown;
        color = const Color(0xFFE94560);
        text = 'Down from last week';
      case Trend.stable:
        icon = PhosphorIconsBold.minus;
        color = const Color(0xFFFFB300);
        text = 'Same as last week';
    }

    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 6),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
        ),
      ],
    );
  }
}