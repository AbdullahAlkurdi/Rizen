import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class RoutineTemplatesPage extends StatelessWidget {
  const RoutineTemplatesPage({super.key});

  static const _templates = [
    _TemplateItem(
      title: 'Developer Archetype',
      description: 'Coding blocks, deep work, exercise, prayer sync.',
      icon: PhosphorIconsBold.code,
      color: Color(0xFF60A5FA),
    ),
    _TemplateItem(
      title: 'Student Archetype',
      description: 'Study sprints, class blocks, revision, rest.',
      icon: PhosphorIconsBold.student,
      color: Color(0xFF818CF8),
    ),
    _TemplateItem(
      title: 'Executive Archetype',
      description: 'High-value meetings, strategy, fitness, family.',
      icon: PhosphorIconsBold.briefcase,
      color: Color(0xFF38BDF8),
    ),
    _TemplateItem(
      title: 'Spiritual-First',
      description: 'Prayer-anchored, with worldly tasks slotted around.',
      icon: PhosphorIconsBold.moonStars,
      color: AppColors.warning,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Routine Templates'),
      ),
      body: ListView(
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
                onTap: () => context.push(AppRoutes.routineCreate),
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
                            t.description,
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
}

class _TemplateItem {
  const _TemplateItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
}
