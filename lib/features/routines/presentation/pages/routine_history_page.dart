import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../data/models/routine_model.dart';
import '../bloc/routines_bloc.dart';

class RoutineHistoryPage extends StatefulWidget {
  const RoutineHistoryPage({super.key});

  @override
  State<RoutineHistoryPage> createState() => _RoutineHistoryPageState();
}

class _RoutineHistoryPageState extends State<RoutineHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<RoutineCubit>().loadRoutines();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown';
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatDuration(DateTime? created, DateTime? updated) {
    final ref = updated ?? created;
    if (ref == null) return '0h 0m';
    return '~${ref.difference(created ?? ref).inHours}h';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutineCubit, RoutineState>(
      buildWhen: (prev, curr) =>
          curr.routines != prev.routines || curr.isLoading != prev.isLoading,
      builder: (context, state) {
        final routines = List<Routine>.from(state.routines)
          ..sort(
            (a, b) => (b.updatedAt ?? b.createdAt).compareTo(
              a.updatedAt ?? a.createdAt,
            ),
          );

        return RizenScaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(PhosphorIconsBold.arrowLeft),
              onPressed: () => context.pop(),
            ),
            title: const Text('Routine History'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const PageHeader(
                title: 'Archival View',
                subtitle: 'Past routine iterations and version history.',
              ),
              const SizedBox(height: 20),
              if (state.isLoading && routines.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(32),
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
              else if (routines.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(
                          PhosphorIconsBold.clockCounterClockwise,
                          color: AppColors.textMuted,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No routine history yet',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Create and update routines to build your history.',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              else
                ...routines.map((routine) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GlassCard(
                      onTap: () =>
                          context.push('/routines/detail/${routine.id}'),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.15),
                              borderRadius: AppTheme.cardRadius,
                            ),
                            child: Icon(
                              PhosphorIconsBold.clockCounterClockwise,
                              color: AppColors.accent,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  routine.title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  '${_formatDate(routine.updatedAt ?? routine.createdAt)} · ${_formatDuration(routine.createdAt, routine.updatedAt)} · ${routine.streak}d active',
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
            ],
          ),
        );
      },
    );
  }
}
