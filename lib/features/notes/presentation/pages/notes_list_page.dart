import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../cubit/notes_cubit.dart';

class NotesListPage extends StatelessWidget {
  const NotesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NotesCubit>().state;

    return RizenScaffold(
      extendBody: true,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      body: RefreshIndicator(
        onRefresh: () => context.read<NotesCubit>().loadNotes(),
        child: ListView(
          children: [
            const PageHeader(
              title: 'Notes & Reflections',
              subtitle: 'Cognitive offloading and nightly journaling.',
            ),
            const SizedBox(height: 20),
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
              NotesInitial() || NotesLoading() => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: CircularProgressIndicator(),
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
              NotesLoaded(:final notes) => Column(
                  children: [
                    if (notes.isEmpty)
                      Padding(
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
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: AppColors.textMuted),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tap the button below to create your first note.',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.textMuted),
                            ),
                          ],
                        ),
                      )
                    else
                      for (final note in notes)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GlassCard(
                            onTap: () =>
                                context.push(AppRoutes.noteDetail(note.id)),
                            child: Row(
                              children: [
                                if (note.tags.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 14),
                                    child: Container(
                                      width: 4,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        color: AppColors.accent,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        note.title,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        note.content,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _formatDate(note.loggedAt),
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(color: AppColors.textMuted),
                                ),
                              ],
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
                  ],
                ),
            },
          ],
        ),
      ),
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
