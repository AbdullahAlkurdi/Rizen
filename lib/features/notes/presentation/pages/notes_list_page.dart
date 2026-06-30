import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../domain/entities/note_category.dart';
import '../../domain/services/reflection_prompts_service.dart';
import '../cubit/notes_cubit.dart';

class NotesListPage extends StatefulWidget {
  const NotesListPage({super.key});

  @override
  State<NotesListPage> createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  NoteCategory? _selectedCategory;
  late final ReflectionPromptsService _promptsService;

  @override
  void initState() {
    super.initState();
    _promptsService = ReflectionPromptsService();
    context.read<NotesCubit>().loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NotesCubit>().state;

    return RizenScaffold(
      extendBody: true,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      appBar: AppBar(
        title: const Text('Notes & Reflections'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.noteCreate),
        backgroundColor: const Color(0xFFE94560),
        child: const Icon(PhosphorIconsBold.plus),
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<NotesCubit>().loadNotes(),
        child: ListView(
          children: [
            const PageHeader(
              title: 'Notes & Reflections',
              subtitle: 'Cognitive offloading and nightly journaling.',
            ),
            const SizedBox(height: 16),
            _QuickPromptRow(
              dailyPrompt: _promptsService.getDailyPrompt(),
              onCreatePressed: () => context.push(AppRoutes.noteCreate),
            ),
            const SizedBox(height: 16),
            _CategoryFilterChips(
              selectedCategory: _selectedCategory,
              onChanged: (cat) {
                setState(() => _selectedCategory = cat);
              },
            ),
            const SizedBox(height: 16),
            _StreakCard(
              notes: state is NotesLoaded ? state.notes : const [],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search notes...',
                  prefixIcon: const Icon(PhosphorIconsBold.magnifyingGlass),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    context.read<NotesCubit>().searchNotes(value.trim());
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            switch (state) {
              NotesInitial() || NotesLoading() => const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SkeletonListTile(),
                      SizedBox(height: 10),
                      SkeletonListTile(),
                      SizedBox(height: 10),
                      SkeletonListTile(),
                    ],
                  ),
                ),
              NotesError(:final message) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Icon(
                          PhosphorIconsBold.warningCircle,
                          color: AppColors.warning,
                          size: 40,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          message,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.warning,
                              ),
                        ),
                        const SizedBox(height: 16),
                        RizenButton(
                          label: 'Retry',
                          variant: RizenButtonVariant.secondary,
                          onPressed: () => context.read<NotesCubit>().loadNotes(),
                        ),
                      ],
                    ),
                  ),
                ),
              NotesLoaded(:final notes) => _NotesListView(
                  notes: notes,
                  selectedCategory: _selectedCategory,
                ),
            },
          ],
        ),
      ),
    );
  }
}

class _QuickPromptRow extends StatelessWidget {
  const _QuickPromptRow({
    required this.dailyPrompt,
    required this.onCreatePressed,
  });

  final String dailyPrompt;
  final VoidCallback onCreatePressed;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Reflection',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: const Color(0xFF0F3460),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            dailyPrompt,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          RizenButton(
            label: 'Write Now',
            icon: PhosphorIconsBold.pencilSimple,
            variant: RizenButtonVariant.secondary,
            onPressed: onCreatePressed,
          ),
        ],
      ),
    );
  }
}

class _CategoryFilterChips extends StatelessWidget {
  const _CategoryFilterChips({
    required this.selectedCategory,
    required this.onChanged,
  });

  final NoteCategory? selectedCategory;
  final ValueChanged<NoteCategory?> onChanged;

  final Map<NoteCategory, String> _categoryLabels = const {
    NoteCategory.reflection: 'Reflection',
    NoteCategory.gratitude: 'Gratitude',
    NoteCategory.brainDump: 'Brain Dump',
    NoteCategory.insight: 'Insight',
    NoteCategory.custom: 'Custom',
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: const Text('All'),
              selected: selectedCategory == null,
              onSelected: (_) => onChanged(null),
              selectedColor: const Color(0xFFE94560),
              labelStyle: TextStyle(
                color: selectedCategory == null
                    ? Colors.white
                    : const Color(0xFF0F3460),
              ),
            ),
          ),
          ...NoteCategory.values.map((cat) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(_categoryLabels[cat]!),
                selected: selectedCategory == cat,
                onSelected: (_) => onChanged(cat),
                selectedColor: const Color(0xFFE94560),
                labelStyle: TextStyle(
                  color: selectedCategory == cat
                      ? Colors.white
                      : const Color(0xFF0F3460),
                ),
              ),
            )),
        ],
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.notes});

  final List<dynamic> notes;

  @override
  Widget build(BuildContext context) {
    final streakDates = notes
        .map((n) => DateTime(
              n.loggedAt.year,
              n.loggedAt.month,
              n.loggedAt.day,
            ))
        .toSet()
        .toList();

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    int currentStreak = 0;
    if (streakDates.contains(today)) {
      currentStreak = _calculateStreak(streakDates, today);
    }

    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            PhosphorIconsBold.notePencil,
            color: const Color(0xFF0F3460),
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Writing Streak',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  streakDates.isEmpty
                      ? 'Start your first note today'
                      : '$currentStreak days',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (currentStreak < 30 && streakDates.isNotEmpty)
            Text(
              '${30 - currentStreak} days to 30-day streak',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
        ],
      ),
    );
  }

  int _calculateStreak(List<DateTime> dates, DateTime today) {
    int streak = 0;
    DateTime current = today;
    while (dates.contains(current)) {
      streak++;
      current = DateTime(current.year, current.month, current.day - 1);
    }
    return streak;
  }
}

class _NotesListView extends StatelessWidget {
  const _NotesListView({
    required this.notes,
    required this.selectedCategory,
  });

  final List<dynamic> notes;
  final NoteCategory? selectedCategory;

  static const Map<NoteCategory, Color> _categoryColors = {
    NoteCategory.reflection: Color(0xFF4CAF50),
    NoteCategory.gratitude: Color(0xFFFFB300),
    NoteCategory.brainDump: Color(0xFF42A5F5),
    NoteCategory.insight: Color(0xFFAB47BC),
    NoteCategory.custom: Color(0xFF78909C),
  };

  @override
  Widget build(BuildContext context) {
    final filteredNotes = selectedCategory == null
        ? notes
        : notes.where((n) => n.category == selectedCategory).toList();

    final sortedNotes = [...filteredNotes]
      ..sort((a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        return b.loggedAt.compareTo(a.loggedAt);
      });

    if (filteredNotes.isEmpty && notes.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(
              PhosphorIconsBold.notebook,
              color: AppColors.textMuted,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              'No notes in this category',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textMuted,
                  ),
            ),
          ],
        ),
      );
    }

    if (notes.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(
              PhosphorIconsBold.notebook,
              color: AppColors.textMuted,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              'No notes yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textMuted,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tap the + button below to create your first note.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                  ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        for (final note in sortedNotes)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GlassCard(
              onTap: () => context.push(AppRoutes.noteDetail(note.id)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (note.isPinned)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        PhosphorIconsBold.pushPin,
                        size: 16,
                        color: Color(0xFFE94560),
                      ),
                    ),
                  if (note.category != null)
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _categoryColors[note.category]!
                            .withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _categoryColors[note.category]!,
                        ),
                      ),
                      child: Text(
                        note.category!.name,
                        style: TextStyle(
                          fontSize: 10,
                          color: _categoryColors[note.category],
                        ),
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.title,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          note.content,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (note.tags.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 4,
                            children: note.tags.take(3).map((tag) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0F3460).withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  tag,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatDate(note.loggedAt),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textMuted,
                        ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.month}/${date.day}/${date.year}';
  }
}