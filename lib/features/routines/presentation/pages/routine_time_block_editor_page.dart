import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../data/models/routine_model.dart';
import '../bloc/routines_bloc.dart';

class RoutineTimeBlockEditorPage extends StatefulWidget {
  final String routineId;

  const RoutineTimeBlockEditorPage({super.key, required this.routineId});

  @override
  State<RoutineTimeBlockEditorPage> createState() =>
      _RoutineTimeBlockEditorPageState();
}

class _RoutineTimeBlockEditorPageState
    extends State<RoutineTimeBlockEditorPage> {
  @override
  void initState() {
    super.initState();
    _loadBlocks();
  }

  Future<void> _loadBlocks() async {
    await context.read<RoutineCubit>().loadTimeBlocks(widget.routineId);
  }

  String _formatTime(int minutes) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
  }

  void _openBlockDialog({TimeBlock? block}) {
    final isEditing = block != null;
    final titleController = TextEditingController(text: block?.title ?? '');
    final descriptionController = TextEditingController(
      text: block?.description ?? '',
    );
    int startTime = block?.startTime ?? 9 * 60;
    int endTime = block?.endTime ?? 10 * 60;
    String domainId = block?.domainId ?? 'work';
    TimeBlockAnchor anchor = block?.anchor ?? TimeBlockAnchor.exact;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(isEditing ? 'Edit Time Block' : 'Add Time Block'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Block Title',
                    prefixIcon: Icon(PhosphorIconsBold.pen),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: domainId,
                  decoration: const InputDecoration(
                    labelText: 'Domain',
                    prefixIcon: Icon(PhosphorIconsBold.folder),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'sports', child: Text('Sports')),
                    DropdownMenuItem(value: 'study', child: Text('Study')),
                    DropdownMenuItem(value: 'work', child: Text('Work')),
                    DropdownMenuItem(value: 'coding', child: Text('Coding')),
                    DropdownMenuItem(
                      value: 'cooking',
                      child: Text('Cooking/Nutrition'),
                    ),
                    DropdownMenuItem(
                      value: 'spiritual',
                      child: Text('Spiritual'),
                    ),
                    DropdownMenuItem(value: 'custom', child: Text('Custom')),
                  ],
                  onChanged: (v) =>
                      setDialogState(() => domainId = v ?? 'work'),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Start Time',
                          hintText: '09:00',
                        ),
                        initialValue: _formatTime(startTime),
                        readOnly: true,
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: ctx,
                            initialTime: TimeOfDay(
                              hour: startTime ~/ 60,
                              minute: startTime % 60,
                            ),
                          );
                          if (picked != null) {
                            setDialogState(() {
                              startTime = picked.hour * 60 + picked.minute;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'End Time',
                          hintText: '10:00',
                        ),
                        initialValue: _formatTime(endTime),
                        readOnly: true,
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: ctx,
                            initialTime: TimeOfDay(
                              hour: endTime ~/ 60,
                              minute: endTime % 60,
                            ),
                          );
                          if (picked != null) {
                            setDialogState(() {
                              endTime = picked.hour * 60 + picked.minute;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<TimeBlockAnchor>(
                  initialValue: anchor,
                  decoration: const InputDecoration(
                    labelText: 'Anchor Type',
                    prefixIcon: Icon(PhosphorIconsBold.anchorSimple),
                  ),
                  items: TimeBlockAnchor.values
                      .map(
                        (a) => DropdownMenuItem(value: a, child: Text(a.label)),
                      )
                      .toList(),
                  onChanged: (v) =>
                      setDialogState(() => anchor = v ?? TimeBlockAnchor.exact),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Description (optional)',
                    prefixIcon: Icon(PhosphorIconsBold.textAa),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => ctx.pop(), child: const Text('Cancel')),
            RizenButton(
              label: isEditing ? 'Update' : 'Add Block',
              icon: isEditing
                  ? PhosphorIconsBold.floppyDisk
                  : PhosphorIconsBold.plus,
              onPressed: () async {
                if (titleController.text.trim().isEmpty) return;
                if (endTime <= startTime) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    const SnackBar(
                      content: Text('End time must be after start time'),
                    ),
                  );
                  return;
                }
                ctx.pop();
                if (isEditing) {
                  await context.read<RoutineCubit>().updateTimeBlock(
                    routineId: widget.routineId,
                    blockId: block.id,
                    updates: {
                      'title': titleController.text.trim(),
                      'domainId': domainId,
                      'startTime': startTime,
                      'endTime': endTime,
                      'durationMinutes': endTime - startTime,
                      'anchor': anchor.name,
                      'description': descriptionController.text.trim(),
                    },
                  );
                } else {
                  await context.read<RoutineCubit>().addTimeBlock(
                    routineId: widget.routineId,
                    title: titleController.text.trim(),
                    domainId: domainId,
                    startTime: startTime,
                    endTime: endTime,
                    description: descriptionController.text.trim(),
                    anchor: anchor,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _moveBlock(int index, int direction) async {
    if (!mounted) return;
    final sorted = List<TimeBlock>.from(
      context.read<RoutineCubit>().state.selectedTimeBlocks,
    )..sort((a, b) => a.startTime.compareTo(b.startTime));
    final newIndex = index + direction;
    if (newIndex < 0 || newIndex >= sorted.length) return;

    final block = sorted[index];
    final neighbor = sorted[newIndex];
    final swappedStart = neighbor.startTime;
    final swappedEnd = neighbor.endTime;

    await context.read<RoutineCubit>().updateTimeBlock(
      routineId: widget.routineId,
      blockId: block.id,
      updates: {
        'startTime': swappedStart,
        'endTime': swappedEnd,
        'durationMinutes': swappedEnd - swappedStart,
      },
    );
    if (!mounted) return;
    await context.read<RoutineCubit>().updateTimeBlock(
      routineId: widget.routineId,
      blockId: neighbor.id,
      updates: {
        'startTime': block.startTime,
        'endTime': block.endTime,
        'durationMinutes': block.endTime - block.startTime,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutineCubit, RoutineState>(
      buildWhen: (prev, curr) =>
          curr.selectedTimeBlocks != prev.selectedTimeBlocks ||
          curr.isLoading != prev.isLoading,
      builder: (context, state) {
        final blocks = List<TimeBlock>.from(state.selectedTimeBlocks)
          ..sort((a, b) => a.startTime.compareTo(b.startTime));

        return FeatureScaffold(
          title: 'Time-Block Editor',
          subtitle: 'Manage blocks for this routine.',
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openBlockDialog(),
            icon: const Icon(PhosphorIconsBold.plus),
            label: const Text('Add Block'),
          ),
          body: state.isLoading && blocks.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SkeletonListTile(),
                      SizedBox(height: 10),
                      SkeletonListTile(),
                      SizedBox(height: 10),
                      SkeletonListTile(),
                    ],
                  ),
                )
              : blocks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        PhosphorIconsBold.clock,
                        color: AppColors.textMuted,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No time blocks yet',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add time blocks to structure your routine timeline.',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    const PageHeader(
                      title: 'Timeline',
                      subtitle: 'Drag by moving blocks up or down.',
                    ),
                    const SizedBox(height: 20),
                    ...blocks.asMap().entries.map((entry) {
                      final index = entry.key;
                      final block = entry.value;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              if (index < blocks.length - 1)
                                Container(
                                  width: 2,
                                  height: 48,
                                  color: AppColors.glassBorder,
                                ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: GlassCard(
                                onTap: () => _openBlockDialog(block: block),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      PhosphorIconsBold.clock,
                                      color: AppColors.accent,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            block.title,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                          ),
                                          Text(
                                            '${_formatTime(block.startTime)} - ${_formatTime(block.endTime)} · ${block.isCompleted ? 'Done' : 'Pending'}',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        PhosphorIconsBold.caretUp,
                                        size: 18,
                                      ),
                                      onPressed: index > 0
                                          ? () => _moveBlock(index, -1)
                                          : null,
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        PhosphorIconsBold.caretDown,
                                        size: 18,
                                      ),
                                      onPressed: index < blocks.length - 1
                                          ? () => _moveBlock(index, 1)
                                          : null,
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        PhosphorIconsBold.trash,
                                        size: 18,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async {
                                        final cubit = context
                                            .read<RoutineCubit>();
                                        final confirm = await showDialog<bool>(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: const Text(
                                              'Delete Time Block',
                                            ),
                                            content: Text(
                                              'Delete "${block.title}"?',
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
                                        );
                                        if (confirm == true) {
                                          if (!mounted) return;
                                          await cubit.deleteTimeBlock(
                                            routineId: widget.routineId,
                                            blockId: block.id,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
        );
      },
    );
  }
}
