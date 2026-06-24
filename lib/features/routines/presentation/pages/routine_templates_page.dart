import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../data/models/routine_model.dart';
import '../bloc/routines_bloc.dart';

class RoutineTemplatesPage extends StatelessWidget {
  const RoutineTemplatesPage({super.key});

  static const _templates = [
    _TemplateItem(
      id: 'developer',
      title: 'Developer Archetype',
      description: 'Coding blocks, deep work, exercise, prayer sync.',
      icon: PhosphorIconsBold.code,
      color: Color(0xFF60A5FA),
      timeBlocks: [
        _TemplateBlock('Fajr + Reflection', 6 * 60, 6 * 60 + 20, 'spiritual'),
        _TemplateBlock(
          'Deep Coding Session',
          6 * 60 + 30,
          7 * 60 + 45,
          'coding',
        ),
        _TemplateBlock(
          'Breakfast & Planning',
          7 * 60 + 45,
          8 * 60 + 15,
          'cooking',
        ),
        _TemplateBlock(
          'Professional Work Blocks',
          8 * 60 + 45,
          12 * 60,
          'work',
        ),
        _TemplateBlock('Lunch Break', 12 * 60, 13 * 60, 'cooking'),
        _TemplateBlock(
          'Afternoon Coding',
          13 * 60 + 30,
          16 * 60 + 30,
          'coding',
        ),
        _TemplateBlock('Gym / Cardio', 17 * 60, 18 * 60 + 30, 'sports'),
        _TemplateBlock(
          'Evening Reflection',
          21 * 60,
          21 * 60 + 30,
          'spiritual',
        ),
      ],
    ),
    _TemplateItem(
      id: 'student',
      title: 'Student Archetype',
      description: 'Study sprints, class blocks, revision, rest.',
      icon: PhosphorIconsBold.student,
      color: Color(0xFF818CF8),
      timeBlocks: [
        _TemplateBlock('Morning Duas & Fajr', 6 * 60, 6 * 60 + 20, 'spiritual'),
        _TemplateBlock('Study Sprint 1', 7 * 60, 9 * 60, 'study'),
        _TemplateBlock('Class Block', 9 * 60 + 30, 12 * 60, 'study'),
        _TemplateBlock('Lunch & Break', 12 * 60, 13 * 60 + 30, 'cooking'),
        _TemplateBlock('Study Sprint 2', 14 * 60, 16 * 60, 'study'),
        _TemplateBlock('Revision Session', 16 * 60 + 30, 18 * 60, 'study'),
        _TemplateBlock('Exercise', 18 * 60 + 30, 19 * 60 + 30, 'sports'),
        _TemplateBlock('Reading', 20 * 60, 21 * 60, 'study'),
      ],
    ),
    _TemplateItem(
      id: 'executive',
      title: 'Executive Archetype',
      description: 'High-value meetings, strategy, fitness, family.',
      icon: PhosphorIconsBold.briefcase,
      color: Color(0xFF38BDF8),
      timeBlocks: [
        _TemplateBlock('Fajr & Meditation', 5 * 60 + 30, 6 * 60, 'spiritual'),
        _TemplateBlock('Deep Work Block', 6 * 60 + 30, 9 * 60, 'work'),
        _TemplateBlock('Strategy Review', 9 * 60 + 30, 11 * 60, 'work'),
        _TemplateBlock('Meetings Block', 11 * 60 + 30, 14 * 60, 'work'),
        _TemplateBlock('Lunch & Walk', 14 * 60, 15 * 60, 'cooking'),
        _TemplateBlock(
          'Leadership Reading',
          15 * 60 + 30,
          16 * 60 + 30,
          'study',
        ),
        _TemplateBlock('Fitness Session', 17 * 60, 18 * 60, 'sports'),
        _TemplateBlock('Family Time', 18 * 60 + 30, 21 * 60, 'custom'),
      ],
    ),
    _TemplateItem(
      id: 'spiritual_first',
      title: 'Spiritual-First',
      description: 'Prayer-anchored, with worldly tasks slotted around.',
      icon: PhosphorIconsBold.moonStars,
      color: AppColors.warning,
      timeBlocks: [
        _TemplateBlock('Fajr & Quran', 5 * 60, 5 * 60 + 45, 'spiritual'),
        _TemplateBlock('Morning Adhkar', 6 * 60, 6 * 60 + 15, 'spiritual'),
        _TemplateBlock('Deep Work', 7 * 60, 10 * 60 + 30, 'work'),
        _TemplateBlock('Dhuhr Break', 12 * 60 + 30, 13 * 60 + 30, 'spiritual'),
        _TemplateBlock('Afternoon Focus', 14 * 60, 17 * 60, 'coding'),
        _TemplateBlock('Asr & Reflection', 17 * 60 + 30, 18 * 60, 'spiritual'),
        _TemplateBlock('Maghrib & Family', 18 * 60 + 30, 20 * 60, 'custom'),
        _TemplateBlock('Isha & Wind-down', 21 * 60, 22 * 60, 'spiritual'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Routine Templates'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const PageHeader(
            title: 'Template Library',
            subtitle: 'Open-source preset configurations for every archetype.',
          ),
          const SizedBox(height: 20),
          ..._templates.map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GlassCard(
                onTap: () => _applyTemplate(context, t),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: t.color.withValues(alpha: 0.15),
                        borderRadius: AppTheme.cardRadius,
                      ),
                      child: Icon(t.icon, color: t.color, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${t.description} · ${t.timeBlocks.length} blocks',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      PhosphorIconsBold.arrowRight,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _applyTemplate(
    BuildContext context,
    _TemplateItem template,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text('Apply "${template.title}"?'),
        content: Text(
          'This will create a new routine with ${template.timeBlocks.length} pre-configured time blocks from the ${template.title} template.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx, true),
            child: const Text('Apply'),
          ),
        ],
      ),
    );

    if (confirm != true) return;
    if (!context.mounted) return;

    final cubit = context.read<RoutineCubit>();
    final repo = cubit.repository;
    final routineId = await repo.createRoutine(
      title: template.title,
      description: template.description,
    );

    for (final block in template.timeBlocks) {
      await repo.createTimeBlock(
        routineId: routineId,
        title: block.title,
        domainId: block.domainId,
        startTime: block.startTime,
        endTime: block.endTime,
        anchor: TimeBlockAnchor.exact,
      );
    }

    if (context.mounted) {
      context.push('/routines/detail/$routineId');
    }
  }
}

class _TemplateItem {
  const _TemplateItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.timeBlocks,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<_TemplateBlock> timeBlocks;
}

class _TemplateBlock {
  const _TemplateBlock(this.title, this.startTime, this.endTime, this.domainId);
  final String title;
  final int startTime;
  final int endTime;
  final String domainId;
}
