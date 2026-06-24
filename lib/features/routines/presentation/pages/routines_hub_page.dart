import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../bloc/routines_bloc.dart';

class RoutinesHubPage extends StatefulWidget {
  const RoutinesHubPage({super.key});

  @override
  State<RoutinesHubPage> createState() => _RoutinesHubPageState();
}

class _RoutinesHubPageState extends State<RoutinesHubPage> {
  @override
  void initState() {
    super.initState();
    context.read<RoutineCubit>().loadRoutines();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutineCubit, RoutineState>(
      builder: (context, state) {
        return RizenScaffold(
          extendBody: true,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.error != null
              ? Center(child: Text('Error: ${state.error}'))
              : state.routines.isEmpty
              ? _EmptyState()
              : ListView(
                  children: [
                    const PageHeader(
                      title: 'Routines',
                      subtitle: 'Dynamic schedules and adaptive time-blocking.',
                    ),
                    const SizedBox(height: 20),
                    ...state.routines.map(
                      (routine) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GlassCard(
                          onTap: () =>
                              context.push('/routines/detail/${routine.id}'),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.accent.withValues(
                                    alpha: 0.15,
                                  ),
                                  borderRadius: AppTheme.cardRadius,
                                ),
                                child: Icon(
                                  PhosphorIconsBold.calendar,
                                  color: AppColors.accent,
                                  size: 24,
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
                                      ).textTheme.titleLarge,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${(routine.timeBlockIds.length)} blocks · ${(routine.isEnabled) ? 'Active' : 'Paused'} · ${routine.streak}d streak',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
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
                      ),
                    ),
                    const SizedBox(height: 16),
                    RizenButton(
                      label: 'Create New Routine',
                      icon: PhosphorIconsBold.plus,
                      onPressed: () => context.push(AppRoutes.routineCreate),
                    ),
                    const SizedBox(height: 12),
                    NavGlassTile(
                      title: 'AI Routine Generator',
                      subtitle: 'Let Gemini build your schedule from a prompt.',
                      icon: PhosphorIconsBold.magicWand,
                      iconColor: AppColors.shadow,
                      onTap: () => context.push(AppRoutes.routineAiGenerator),
                    ),
                    const SizedBox(height: 10),
                    NavGlassTile(
                      title: 'Routine Templates',
                      subtitle: 'Preset configurations for common archetypes.',
                      icon: PhosphorIconsBold.files,
                      iconColor: Color(0xFF60A5FA),
                      onTap: () => context.push(AppRoutes.routineTemplates),
                    ),
                    const SizedBox(height: 10),
                    NavGlassTile(
                      title: 'Historical Routine Log',
                      subtitle: 'Review past routine iterations.',
                      icon: PhosphorIconsBold.clockCounterClockwise,
                      iconColor: Color(0xFF4ADE80),
                      onTap: () => context.push(AppRoutes.routineHistory),
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
    return Column(
      children: [
        const SizedBox(height: 60),
        Icon(PhosphorIconsBold.calendar, color: AppColors.textMuted, size: 64),
        const SizedBox(height: 16),
        Text('No routines yet', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          'Create your first routine to get started.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
