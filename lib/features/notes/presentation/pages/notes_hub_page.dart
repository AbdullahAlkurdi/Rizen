import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../../../core/tutorials/tutorial_mixin.dart';
import '../../../../core/services/tutorial_service.dart';
import '../../../../core/tutorials/rizen_tutorial.dart';
import '../cubit/notes_cubit.dart';

class NotesHubPage extends StatefulWidget {
  const NotesHubPage({super.key});

  @override
  State<NotesHubPage> createState() => _NotesHubPageState();
}

class _NotesHubPageState extends State<NotesHubPage> with TutorialMixin {
  @override
  String get tutorialKey => TutorialService.keys['notes_hub']!;

  @override
  List<TargetFocus> buildTargets() => RizenTutorial.notesHub(_tutorialKeys);

  final Map<String, GlobalKey> _tutorialKeys = {
    'grid': GlobalKey(),
    'create': GlobalKey(),
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
    final state = context.watch<NotesCubit>().state;

    return RizenScaffold(
      extendBody: true,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      appBar: AppBar(
        title: const Text('Notes & Reflections'),
        actions: [
          IconButton(
            onPressed: showTutorialNow,
            icon: const Icon(PhosphorIconsBold.question),
            color: const Color(0xFF9CA3AF),
            tooltip: 'Help',
          ),
        ],
      ),
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
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(PhosphorIconsBold.microphone),
                  ),
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
                      Container(
                        key: _tutorialKeys['grid'],
                        child: Column(
                          children: [
                            for (final note in notes)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: GlassCard(
                                  onTap: () => context.push(AppRoutes.noteDetail(note.id)),
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
                          ],
                        ),
                      ),
                    const SizedBox(height: 16),
                    Container(
                      key: _tutorialKeys['create'],
                      child: RizenButton(
                        label: 'Create Note',
                        icon: PhosphorIconsBold.plus,
                        onPressed: () => context.push(AppRoutes.noteCreate),
                      ),
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
                      iconColor: const Color(0xFF60A5FA),
                      onTap: () => context.push(AppRoutes.notesSearch),
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
