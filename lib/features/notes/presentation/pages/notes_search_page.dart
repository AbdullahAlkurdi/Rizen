import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class NotesSearchPage extends StatelessWidget {
  const NotesSearchPage({super.key});

  static const _results = [
    _SearchResult(
      'Evening Reflection',
      'How did the day feel?',
      'Reflection',
      Color(0xFF60A5FA),
    ),
    _SearchResult(
      'Book Notes',
      'Atomic Habits insights',
      'Study',
      Color(0xFF818CF8),
    ),
    _SearchResult(
      'Meeting Takeaways',
      'Key decisions and action items',
      'Work',
      Color(0xFF38BDF8),
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
        title: const Text('Search Notes'),
      ),
      body: ListView(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search notes by meaning or keyword...',
              prefixIcon: Icon(PhosphorIconsBold.magnifyingGlass),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(PhosphorIconsBold.microphone),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Search Results',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          ..._results.map(
            (r) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                onTap: () => context.push(AppRoutes.noteDetail('search_note_1')),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: r.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        PhosphorIconsBold.notebook,
                        color: r.color,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            r.excerpt,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: r.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        r.tag,
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall?.copyWith(color: r.color),
                      ),
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

class _SearchResult {
  const _SearchResult(this.title, this.excerpt, this.tag, this.color);
  final String title;
  final String excerpt;
  final String tag;
  final Color color;
}
