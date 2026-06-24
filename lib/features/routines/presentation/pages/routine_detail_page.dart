import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../data/models/routine_model.dart';
import '../bloc/routines_bloc.dart';

class RoutineDetailPage extends StatefulWidget {
  final String routineId;

  const RoutineDetailPage({super.key, required this.routineId});

  @override
  State<RoutineDetailPage> createState() => _RoutineDetailPageState();
}

class _RoutineDetailPageState extends State<RoutineDetailPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await context.read<RoutineCubit>().loadRoutineDetail(widget.routineId);
    if (!mounted) return;
    await context.read<RoutineCubit>().loadTimeBlocks(widget.routineId);
  }

  String _formatTime(int minutes) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    if (h > 0 && m > 0) return '${h}h ${m}m';
    if (h > 0) return '${h}h';
    return '${m}m';
  }

  String _formatTimeRange(int start, int end) {
    final startStr =
        '${start ~/ 60}:${(start % 60).toString().padLeft(2, '0')}';
    final endStr = '${end ~/ 60}:${(end % 60).toString().padLeft(2, '0')}';
    return '$startStr - $endStr';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutineCubit, RoutineState>(
      buildWhen: (prev, curr) =>
          curr.selectedRoutine != null ||
          curr.selectedTimeBlocks != prev.selectedTimeBlocks ||
          curr.isLoading != prev.isLoading,
      builder: (context, state) {
        final routine = state.selectedRoutine;
        final timeBlocks = state.selectedTimeBlocks;
        final isLoading = state.isLoading && routine == null;

        if (isLoading) {
          return const RizenScaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (routine == null) {
          return RizenScaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(PhosphorIconsBold.arrowLeft),
                onPressed: () => context.pop(),
              ),
              title: const Text('Routine Detail'),
            ),
            body: const Center(child: Text('Routine not found')),
          );
        }

        final sortedBlocks = List<TimeBlock>.from(timeBlocks)
          ..sort((a, b) => a.startTime.compareTo(b.startTime));
        final completedCount = sortedBlocks.where((b) => b.isCompleted).length;
        final totalDuration = sortedBlocks.fold<int>(
          0,
          (sum, b) => sum + (b.durationMinutes ?? b.endTime - b.startTime),
        );
        final progress = sortedBlocks.isEmpty
            ? 0.0
            : completedCount / sortedBlocks.length;

        return RizenScaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(PhosphorIconsBold.arrowLeft),
              onPressed: () => context.pop(),
            ),
            title: Text(routine.title),
            actions: [
              IconButton(
                onPressed: () => context.push(
                  AppRoutes.routineEdit.replaceFirst(
                    ':routineId',
                    widget.routineId,
                  ),
                ),
                icon: const Icon(PhosphorIconsBold.pencilSimple),
              ),
              IconButton(
                onPressed: () async {
                  final cubit = context.read<RoutineCubit>();
                  showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Delete Routine'),
                          content: const Text(
                            'Are you sure you want to delete this routine?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => ctx.pop(false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => ctx.pop(true),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      )
                      .then<void>((confirm) async {
                        if (confirm != true) return;
                        if (!mounted) return;
                        await cubit.deleteRoutine(widget.routineId);
                      })
                      .then<void>((_) {
                        if (!mounted) return;
                        // ignore: use_build_context_synchronously
                        context.pop();
                      });
                },
                icon: const Icon(PhosphorIconsBold.dotsThreeVertical),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
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
                          '$completedCount / ${sortedBlocks.length} blocks',
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
                          _formatTime(totalDuration),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.glassFill,
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(4),
                minHeight: 8,
              ),
              const SizedBox(height: 24),
              Text(
                'Time Blocks',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              if (sortedBlocks.isEmpty)
                GlassCard(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Icon(
                          PhosphorIconsBold.clock,
                          color: AppColors.textMuted,
                          size: 32,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No time blocks yet',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add time blocks to build your routine schedule.',
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        RizenButton(
                          label: 'Add Time Block',
                          icon: PhosphorIconsBold.plus,
                          variant: RizenButtonVariant.secondary,
                          onPressed: () => context.push(
                            AppRoutes.routineTimeBlocks.replaceFirst(
                              ':routineId',
                              widget.routineId,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ...sortedBlocks.map((block) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GlassCard(
                      onTap: () async {
                        await context.read<RoutineCubit>().updateTimeBlock(
                          routineId: widget.routineId,
                          blockId: block.id,
                          updates: {'isCompleted': !block.isCompleted},
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: block.isCompleted
                                  ? AppColors.success.withValues(alpha: 0.2)
                                  : AppColors.accent.withValues(alpha: 0.15),
                              borderRadius: AppTheme.cardRadius,
                            ),
                            child: Icon(
                              block.isCompleted
                                  ? PhosphorIconsFill.checkCircle
                                  : PhosphorIconsBold.clock,
                              color: block.isCompleted
                                  ? AppColors.success
                                  : AppColors.accent,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  block.title,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        decoration: block.isCompleted
                                            ? TextDecoration.lineThrough
                                            : null,
                                        color: block.isCompleted
                                            ? AppColors.textMuted
                                            : null,
                                      ),
                                ),
                                Text(
                                  _formatTimeRange(
                                    block.startTime,
                                    block.endTime,
                                  ),
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
                iconColor: const Color(0xFF818CF8),
                onTap: () => context.push(
                  AppRoutes.routineTimeBlocks.replaceFirst(
                    ':routineId',
                    widget.routineId,
                  ),
                ),
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
      },
    );
  }
}
