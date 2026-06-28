import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../features/dashboard/presentation/widgets/open_checklists_widget.dart';
import '../../../routines/presentation/bloc/routines_bloc.dart';
import '../../../routines/data/models/routine_model.dart';

class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RoutineCubit>().loadRoutines();
    return BlocBuilder<RoutineCubit, RoutineState>(
      builder: (context, state) {
        final hour = DateTime.now().hour;
        final greeting = hour < 17 ? 'Good morning' : 'Good evening';
        final isMorning = hour < 17;

        TimeBlock? activeBlock;
        if (state.activeTimeBlocks.isNotEmpty) {
          activeBlock = state.activeTimeBlocks.first;
        }

        return RizenScaffold(
          extendBody: true,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          floatingActionButton: FloatingActionButton.large(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Voice logging — Gemini integration coming in Phase 4',
                  ),
                ),
              );
            },
            child: Icon(PhosphorIconsFill.microphone, size: 28),
          ),
          body: ListView(
            children: [
              if (state.isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
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
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: AppColors.textMuted),
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
              if (activeBlock != null) _ActiveTimeBlockCard(block: activeBlock),
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
              const OpenChecklistsWidget(),
              const SizedBox(height: 20),
              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              GridView.count(
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
