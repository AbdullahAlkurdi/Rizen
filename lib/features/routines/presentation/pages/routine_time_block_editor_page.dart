import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../data/models/routine_model.dart';
import '../bloc/routines_bloc.dart';

class RoutineTimeBlockEditorPage extends StatelessWidget {
  const RoutineTimeBlockEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutineCubit, RoutineState>(
      builder: (context, state) {
        final routine = ModalRoute.of(context)?.settings.arguments as Routine?;
        final timeBlocks = routine != null 
            ? state.activeTimeBlocks.where((b) => b.startTime > 0).toList()
            : [];

        return FeatureScaffold(
          title: 'Time-Block Editor',
          subtitle: 'Drag blocks to reorganize your daily timeline.',
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            icon: Icon(PhosphorIconsBold.plus),
            label: Text('Add Block'),
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : timeBlocks.isEmpty
                  ? _EmptyState()
                  : ListView(
                      children: [
                        GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Timeline',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 20),
                              ...timeBlocks.asMap().entries.map((entry) {
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
                                        if (index < timeBlocks.length - 1)
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
                                          onTap: () {},
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(PhosphorIconsBold.clock, color: AppColors.accent, size: 20),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      block.title,
                                                      style: Theme.of(context).textTheme.titleMedium,
                                                    ),
                                                    Text(
                                                      '${block.startTime ~/ 60}:${(block.startTime % 60).toString().padLeft(2, '0')} - ${block.endTime ~/ 60}:${(block.endTime % 60).toString().padLeft(2, '0')}',
                                                      style: Theme.of(context).textTheme.bodySmall,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Icon(
                                                PhosphorIconsBold.listDashes,
                                                color: AppColors.textMuted,
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
                        ),
                      ],
                    ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
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
              'Create a routine and add time blocks to get started.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}