import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/tutorials/tutorial_mixin.dart';
import '../../../../core/services/tutorial_service.dart';
import '../../../../core/tutorials/rizen_tutorial.dart';
import '../../data/repositories/shadow_tracker_repository.dart';
import '../cubit/shadow_tracker_cubit.dart';
import '../../../todo/domain/usecases/get_missed_items_usecase.dart';
import '../../../todo/data/repositories/todo_repository_impl.dart';

class ShadowTrackerPage extends StatelessWidget {
  const ShadowTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShadowTrackerCubit(
        shadowTrackerRepository: ShadowTrackerRepository(),
        getMissedItemsUseCase: GetMissedItemsUseCase(TodoRepositoryImpl()),
      )..loadShadowData(),
      child: ShadowTrackerView(),
    );
  }
}

class ShadowTrackerView extends StatefulWidget {
  const ShadowTrackerView({super.key});

  @override
  State<ShadowTrackerView> createState() => _ShadowTrackerViewState();
}

class _ShadowTrackerViewState extends State<ShadowTrackerView> with TutorialMixin {
  @override
  String get tutorialKey => TutorialService.keys['shadow_tracker']!;

  @override
  List<TargetFocus> buildTargets() => RizenTutorial.shadowTracker(_tutorialKeys);

  final Map<String, GlobalKey> _tutorialKeys = {
    'score': GlobalKey(),
    'missed': GlobalKey(),
    'recovery': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) maybeShowTutorial();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Shadow Score',
      actions: [
        IconButton(
          onPressed: showTutorialNow,
          icon: const Icon(PhosphorIconsBold.question),
          color: const Color(0xFF9CA3AF),
          tooltip: 'Help',
        ),
      ],
      body: ListView(
        children: [
          _ScoreHeader(),
          const SizedBox(height: 20),
          _MissedItemsCard(),
          const SizedBox(height: 20),
          _ShadowLogList(),
          const SizedBox(height: 20),
          _RecoveryBanner(),
        ],
      ),
    );
  }
}

class _ScoreHeader extends StatefulWidget {
  const _ScoreHeader();

  @override
  State<_ScoreHeader> createState() => _ScoreHeaderState();
}

class _ScoreHeaderState extends State<_ScoreHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _targetValue = 0;
  final double _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateTo(double value) {
    if (_targetValue == value) return;
    _targetValue = value;
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ShadowTrackerCubit, ShadowTrackerState, double?>(
      selector: (state) {
        if (state is ShadowTrackerLoaded) return state.totalImpact;
        if (state is ShadowTrackerLoadingMore) return state.previousState.totalImpact;
        return null;
      },
      builder: (context, impact) {
        if (impact != null) {
          _animateTo(impact);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Shadow Score',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'What your resistance has cost you',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textMuted,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final progress = CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeOutCubic,
                ).value;
                final value = _currentValue + (_targetValue - _currentValue) * progress;
                return Text(
                  value.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w900,
                      ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _MissedItemsCard extends StatelessWidget {
  const _MissedItemsCard();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ShadowTrackerCubit, ShadowTrackerState,
            ShadowTrackerLoaded?>(
      selector: (state) =>
          state is ShadowTrackerLoaded ? state : null,
      builder: (context, loadedState) {
        if (loadedState == null) {
          return GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      PhosphorIconsBold.warningCircle,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Checklist Misses',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...List.generate(3, (_) => const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: SkeletonLine(height: 20),
                    )),
              ],
            ),
          );
        }

        if (loadedState.missedItems.isEmpty) {
          return GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIconsFill.checkCircle,
                  color: AppColors.success,
                  size: 40,
                ),
                const SizedBox(height: 12),
                Text(
                  'No missed items this month',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }

        final maxCount = loadedState.missedItems
            .map((e) => e.missCount)
            .reduce((a, b) => a > b ? a : b);
        final maxBarWidth = MediaQuery.of(context).size.width - 80;

        return GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    PhosphorIconsBold.warningCircle,
                    color: AppColors.accent,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Checklist Misses',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...loadedState.missedItems.map((item) {
                final barWidth = maxBarWidth * (item.missCount / maxCount);
                final displayTitle = item.title.length > 20
                    ? '${item.title.substring(0, 20)}...'
                    : item.title;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              displayTitle,
                              style: Theme.of(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '×${item.missCount} missed',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textMuted,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            width: barWidth.clamp(0.0, maxBarWidth),
                            height: 8,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: const [Color(0xFFE94560), Color(0xFF0F3460)],
                                begin: AlignmentDirectional.centerStart,
                                end: AlignmentDirectional.centerEnd,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        },
                      ),
                    ],
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

class _ShadowLogList extends StatelessWidget {
  const _ShadowLogList();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ShadowTrackerCubit, ShadowTrackerState,
            ShadowTrackerLoaded?>(
      selector: (state) =>
          state is ShadowTrackerLoaded ? state : null,
      builder: (context, loadedState) {
        if (loadedState == null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shadow Log',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              ...List.generate(3, (_) => const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: SkeletonCard(height: 90),
                  )),
            ],
          );
        }

        final logs = loadedState.logs;
        if (logs.isEmpty) {
          return GlassCard(
            child: Text(
              'No shadow events logged yet.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shadow Log',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            ...logs.map((log) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GlassCard(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              log.habitName,
                              style: Theme.of(context).textTheme.bodyLarge,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '${log.date.year}-${log.date.month.toString().padLeft(2, '0')}-${log.date.day.toString().padLeft(2, '0')}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (log.missedItems.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: log.missedItems.map((item) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE94560).withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFFE94560).withValues(alpha: 0.3),
                                ),
                              ),
                              child: Text(
                                item,
                                style: const TextStyle(
                                  color: Color(0xFFE94560),
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      const SizedBox(height: 8),
                      Text(
                        '−${log.shadowImpact.toStringAsFixed(2)} discipline points',
                        style: const TextStyle(
                          color: Color(0xFFE94560),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            if (loadedState.hasMore)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: RizenButton(
                    label: 'Load more',
                    variant: RizenButtonVariant.secondary,
                    onPressed: () =>
                        context.read<ShadowTrackerCubit>().loadMore(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _RecoveryBanner extends StatelessWidget {
  const _RecoveryBanner();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ShadowTrackerCubit, ShadowTrackerState, double?>(
      selector: (state) {
        if (state is ShadowTrackerLoaded) return state.totalImpact;
        return null;
      },
      builder: (context, impact) {
        if (impact == null || impact <= 5.0) return const SizedBox.shrink();

        return GlassCard(
          padding: const EdgeInsets.all(16),
          child: InkWell(
            onTap: () => context.push(AppRoutes.emergencyRecovery),
            borderRadius: AppTheme.cardRadius,
            child: Row(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isRtl = Directionality.of(context) == TextDirection.rtl;
                    return Container(
                      width: 4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE94560),
                        borderRadius: isRtl
                            ? const BorderRadius.only(
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              )
                            : const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 12),
                Icon(
                  PhosphorIconsFill.lightning,
                  color: AppColors.warning,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'You\'ve lost ${impact.toStringAsFixed(1)} discipline points this week. Tap to activate Recovery Mode.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
