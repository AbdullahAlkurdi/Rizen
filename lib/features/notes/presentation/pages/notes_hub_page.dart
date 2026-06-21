import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class NotesHubPage extends StatelessWidget {
  const NotesHubPage({super.key});

  static const _notes = [
    _Note(
      'Evening Reflection',
      'How did the day feel? What would I change?',
      'Jun 18, 2026',
      Color(0xFF60A5FA),
    ),
    _Note(
      'Meeting Takeaways',
      'Key decisions and action items from the team sync.',
      'Jun 17, 2026',
      Color(0xFF818CF8),
    ),
    _Note(
      'Book Notes',
      'Atomic Habits — key insights and quotes.',
      'Jun 15, 2026',
      AppColors.warning,
    ),
    _Note(
      'Project Brainstorm',
      'Feature ideas for the new CLI integration.',
      'Jun 14, 2026',
      AppColors.accent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      extendBody: true,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      body: ListView(
        children: [
          const PageHeader(
            title: 'Notes & Reflections',
            subtitle: 'Cognitive offloading and nightly journaling.',
          ),
          const SizedBox(height: 20),
          ..._notes.map(
            (note) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                onTap: () => context.push(AppRoutes.noteDetail('note_1')),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 44,
                      decoration: BoxDecoration(
                        color: note.color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            note.excerpt,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          note.date,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Icon(
                          PhosphorIconsBold.caretRight,
                          color: AppColors.textMuted,
                          size: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          RizenButton(
            label: 'Create Note',
            icon: PhosphorIconsBold.plus,
            onPressed: () => context.push(AppRoutes.noteCreate),
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Daily Reflection Prompt',
            subtitle: 'Nightly guided cognitive unload.',
            icon: PhosphorIconsBold.notebook,
            iconColor: AppColors.shadow,
            onTap: () => context.push(AppRoutes.dailyReflection),
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Semantic Search',
            subtitle: 'Find notes by meaning, not just keywords.',
            icon: PhosphorIconsBold.magnifyingGlass,
            iconColor: Color(0xFF60A5FA),
            onTap: () => context.push(AppRoutes.notesSearch),
          ),
        ],
      ),
    );
  }
}

class _Note {
  const _Note(this.title, this.excerpt, this.date, this.color);
  final String title;
  final String excerpt;
  final String date;
  final Color color;
}
