import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../../todo/domain/repositories/todo_repository_interface.dart';
import '../cubit/dashboard_todo_cubit.dart';
import '../cubit/dashboard_todo_state.dart';

final GetIt sl = GetIt.instance;

class OpenChecklistsWidget extends StatelessWidget {
  const OpenChecklistsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardTodoCubit(
        getTodoListsByDate: sl<TodoRepositoryInterface>().getTodoListsByDate,
      )..loadTodayChecklists(),
      child: const _OpenChecklistsView(),
    );
  }
}

class _OpenChecklistsView extends StatelessWidget {
  const _OpenChecklistsView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocSelector<DashboardTodoCubit, DashboardTodoState,
            DashboardTodoLoading?>(
          selector: (state) =>
              state is DashboardTodoLoading ? state : null,
          builder: (context, _) {
            return GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SkeletonLine(width: 140, height: 18),
                  SizedBox(height: 8),
                  SkeletonLine(width: 80, height: 14),
                  SizedBox(height: 16),
                  SkeletonLine(width: double.infinity, height: 14),
                  SizedBox(height: 8),
                  SkeletonLine(width: double.infinity, height: 14),
                  SizedBox(height: 8),
                  SkeletonLine(width: double.infinity, height: 14),
                ],
              ),
            );
          },
        ),
        BlocSelector<DashboardTodoCubit, DashboardTodoState,
            DashboardTodoError?>(
          selector: (state) =>
              state is DashboardTodoError ? state : null,
          builder: (context, errorState) {
            if (errorState == null) return const SizedBox.shrink();
            return GlassCard(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    PhosphorIconsFill.warningCircle,
                    color: const Color(0xFFE94560),
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      errorState.message,
                      style: const TextStyle(color: Color(0xFF9CA3AF)),
                    ),
                  ),
                  TextButton(
                    onPressed: errorState.retry,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          },
        ),
        BlocSelector<DashboardTodoCubit, DashboardTodoState,
            ({List<OpenChecklistItem> openItems, bool allComplete})?>(
          selector: (state) {
            if (state is DashboardTodoLoaded) {
              return (openItems: state.openItems, allComplete: state.allComplete);
            }
            return null;
          },
          builder: (context, data) {
            if (data == null) return const SizedBox.shrink();
            final openItems = data.openItems;
            final allComplete = data.allComplete;

            if (allComplete) {
              return _CollapsedDoneCard();
            }

            final visibleItems =
                openItems.length > 3 ? openItems.sublist(0, 3) : openItems;
            final hiddenCount = openItems.length - 3;

            return GlassCard(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Open Checklists',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      _RemainingBadge(count: openItems.length),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...visibleItems.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isLastVisible =
                        index == visibleItems.length - 1 &&
                        hiddenCount <= 0;
                    return _ChecklistItemRow(
                      item: item,
                      showDivider: !isLastVisible,
                    );
                  }),
                  if (hiddenCount > 0) ...[
                    const SizedBox(height: 8),
                    _ShowMoreButton(remaining: hiddenCount),
                  ],
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _CollapsedDoneCard extends StatelessWidget {
  const _CollapsedDoneCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF4CAF50).withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            PhosphorIconsFill.checkCircle,
            color: const Color(0xFF4CAF50),
            size: 18,
          ),
          const SizedBox(width: 10),
          const Text(
            'All checklists done today',
            style: TextStyle(
              color: Color(0xFF4CAF50),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _RemainingBadge extends StatelessWidget {
  const _RemainingBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE94560).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$count remaining',
        style: const TextStyle(
          color: Color(0xFFE94560),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ChecklistItemRow extends StatelessWidget {
  const _ChecklistItemRow({required this.item, required this.showDivider});

  final OpenChecklistItem item;
  final bool showDivider;

  Color _progressColor(double pct) {
    if (pct == 0) return const Color(0xFFE94560);
    if (pct < 70) return const Color(0xFFFFB300);
    return const Color(0xFF4CAF50);
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final displayName = item.parentName.length > 24
        ? '${item.parentName.substring(0, 24)}…'
        : item.parentName;

    return InkWell(
      onTap: () => context.go(item.route),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${item.checkedCount} / ${item.totalCount}',
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            LayoutBuilder(
              builder: (context, constraints) {
                final barAlignment = isRtl
                    ? Alignment.centerRight
                    : Alignment.centerLeft;
                return Stack(
                  children: [
                    Container(
                      width: constraints.maxWidth,
                      height: 3,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F3460),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    AnimatedFractionallySizedBox(
                      widthFactor: item.completionPct / 100,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                      alignment: barAlignment,
                      child: Container(
                        height: 3,
                        decoration: BoxDecoration(
                          color: _progressColor(item.completionPct),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            if (showDivider) ...[
              const SizedBox(height: 14),
              const Divider(
                color: Color(0xFF0F3460),
                thickness: 0.5,
                height: 0,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ShowMoreButton extends StatelessWidget {
  const _ShowMoreButton({required this.remaining});

  final int remaining;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          final cubit = context.read<DashboardTodoCubit>();
          cubit.refresh();
        },
        child: Text(
          'Show $remaining more',
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
