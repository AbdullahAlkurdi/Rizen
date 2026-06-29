import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../core/injection_container.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/services/tutorial_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/tutorials/rizen_tutorial.dart';
import '../../../../core/tutorials/tutorial_mixin.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../../../features/dashboard/presentation/widgets/open_checklists_widget.dart' hide sl;
import '../../../../features/habits/presentation/cubit/habits_cubit.dart';
import '../../../../features/voice/presentation/cubit/voice_cubit.dart';
import '../../../../features/voice/presentation/cubit/voice_state.dart';
import '../../../../features/voice/presentation/widgets/floating_mic_button.dart';
import '../../../../features/voice/presentation/widgets/voice_transcript_overlay.dart';
import '../../../../features/voice/presentation/widgets/voice_result_sheet.dart';
import '../../../../core/services/voice_parser_service.dart';
import '../../../../core/services/voice_log_orchestrator.dart';
import '../../../routines/presentation/bloc/routines_bloc.dart';
import '../../../routines/data/models/routine_model.dart';

class HomeDashboardPage extends StatefulWidget {
  const HomeDashboardPage({super.key});

  @override
  State<HomeDashboardPage> createState() => _HomeDashboardPageState();
}

class _HomeDashboardPageState extends State<HomeDashboardPage> with TutorialMixin {
  @override
  String get tutorialKey => TutorialService.keys['home']!;

  @override
  List<TargetFocus> buildTargets() => RizenTutorial.homeDashboard(_tutorialKeys);

  final Map<String, GlobalKey> _tutorialKeys = {
    'timeblock': GlobalKey(),
    'checklists': GlobalKey(),
    'quickactions': GlobalKey(),
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
    return BlocProvider(
      create: (_) => VoiceCubit(
        parserService: sl<VoiceParserService>(),
        orchestrator: sl<VoiceLogOrchestrator>(),
      ),
      child: Builder(
        builder: (context) {
          context.read<RoutineCubit>().loadRoutines();
          return MultiBlocListener(
            listeners: [
              BlocListener<VoiceCubit, VoiceState>(
                listener: (context, state) {
                  if (state is VoicePermissionDenied) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Microphone permission required. Please enable it in Settings.',
                        ),
                        action: SnackBarAction(
                          label: 'Open Settings',
                          onPressed: () => openAppSettings(),
                        ),
                      ),
                    );
                  }
                  if (state is VoiceSuccess) {
                    VoiceResultSheet.show(
                      context,
                      state.summary,
                      state.result.rawTranscript,
                    ).then((_) {
                      if (!mounted) return;
                      context.read<HabitsCubit>().loadHabits();
                    });
                  }
                },
              ),
              BlocListener<RoutineCubit, RoutineState>(
                listener: (context, state) {},
              ),
            ],
            child: Stack(
              children: [
                BlocBuilder<RoutineCubit, RoutineState>(
                  builder: (context, state) {
                    final hour = DateTime.now().hour;
                    final greeting = hour < 17 ? 'Good morning' : 'Good evening';
                    final isMorning = hour < 17;

                    TimeBlock? activeBlock;
                    if (state.activeTimeBlocks.isNotEmpty) {
                      activeBlock = state.activeTimeBlocks.first;
                    }

                    return RizenScaffold(
                      appBar: AppBar(
                        title: const Text('Home'),
                        actions: [
                          IconButton(
                            onPressed: showTutorialNow,
                            icon: const Icon(PhosphorIconsBold.question),
                            color: const Color(0xFF9CA3AF),
                            tooltip: 'Help',
                          ),
                        ],
                      ),
                      extendBody: true,
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
                      floatingActionButton: const FloatingMicButton(),
                      body: ListView(
                        children: [
                          if (state.isLoading)
                            const Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  SkeletonCard(height: 80),
                                  SizedBox(height: 12),
                                  SkeletonLine(height: 16),
                                  SizedBox(height: 12),
                                  SkeletonLine(height: 16),
                                ],
                              ),
                            ),
                          if (state.error != null)
                            Center(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  'Error: ${state.error}',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      greeting,
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                    Text(
                                      'Abdul',
                                      style: Theme.of(context).textTheme.headlineMedium,
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(PhosphorIconsBold.bell),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          if (activeBlock != null)
                            Container(
                              key: _tutorialKeys['timeblock'] as Key,
                              child: _ActiveTimeBlockCard(block: activeBlock),
                            ),
                          if (activeBlock != null) const SizedBox(height: 16),
                          if (activeBlock == null && !state.isLoading)
                            GlassCard(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  'No active time blocks',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          const SizedBox(height: 20),
                          Container(
                            key: _tutorialKeys['checklists'] as Key,
                            child: const OpenChecklistsWidget(),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Quick Actions',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          Container(
                            key: _tutorialKeys['quickactions'] as Key,
                            child: GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 1.6,
                              children: const [
                                _QuickActionTile(
                                  label: 'Log Activity',
                                  icon: PhosphorIconsBold.plusCircle,
                                  color: Color(0xFFE94560),
                                  route: AppRoutes.domains,
                                ),
                                _QuickActionTile(
                                  label: 'Check Habits',
                                  icon: PhosphorIconsBold.checkCircle,
                                  color: Color(0xFF4ADE80),
                                  route: AppRoutes.habits,
                                ),
                                _QuickActionTile(
                                  label: 'Burnout Mode',
                                  icon: PhosphorIconsBold.firstAid,
                                  color: Color(0xFFFBBF24),
                                  route: AppRoutes.habitsRecovery,
                                ),
                                _QuickActionTile(
                                  label: 'AI Coach',
                                  icon: PhosphorIconsBold.robot,
                                  color: Color(0xFF9333EA),
                                  route: AppRoutes.coachHome,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  isMorning ? 'Today\'s Flow' : 'Evening Wrap-up',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              TextButton(
                                onPressed: () => context.go(AppRoutes.weeklyOverview),
                                child: const Text('Weekly view'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ...(state.activeTimeBlocks).skip(1).map((block) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: GlassCard(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 16,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 4,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        color: AppColors.accent,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    const SizedBox(width: 14),
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
                                      PhosphorIconsBold.caretRight,
                                      color: AppColors.textMuted,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          if (state.activeTimeBlocks.length <= 1 && !state.isLoading)
                            GlassCard(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  'No upcoming blocks today',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          const SizedBox(height: 16),
                          GlassCard(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.shadow.withValues(alpha: 0.2),
                                AppColors.cardBackground.withValues(alpha: 0.6),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(PhosphorIconsFill.skull, color: AppColors.shadow),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Shadow Score: 23',
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                      Text(
                                        'Doom scrolling stole 45 mins from Coding today.',
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                BlocBuilder<VoiceCubit, VoiceState>(
                  builder: (context, state) {
                    if (state is VoiceListening && state.partialTranscript.isNotEmpty) {
                      return VoiceTranscriptOverlay(
                        partialTranscript: state.partialTranscript,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ActiveTimeBlockCard extends StatelessWidget {
  const _ActiveTimeBlockCard({required this.block});

  final TimeBlock block;

  @override
  Widget build(BuildContext context) {
    final remainingMinutes =
        block.endTime - (DateTime.now().hour * 60 + DateTime.now().minute);

    return GlassCard(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.accent.withValues(alpha: 0.25),
          AppColors.cardBackground.withValues(alpha: 0.8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(PhosphorIconsBold.clock, color: AppColors.accent),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Active Time Block',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      block.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$remainingMinutes',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.accent,
                  height: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 6),
                child: Text(
                  'mins remaining',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.primaryBackground,
                ),
                child: const Text('Focus'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.55,
            backgroundColor: AppColors.glassFill,
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(4),
            minHeight: 6,
          ),
        ],
      ),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({
    required this.label,
    required this.icon,
    required this.color,
    required this.route,
  });

  final String label;
  final IconData icon;
  final Color color;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: () => context.go(route),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const Spacer(),
          Text(label, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}