import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../domain/entities/note_category.dart';
import '../cubit/notes_cubit.dart';

class NoteDetailPage extends StatefulWidget {
  const NoteDetailPage({super.key, required this.noteId});

  final String noteId;

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotesCubit>().loadNote(widget.noteId);
  }

  Future<void> _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    if (!mounted) return;
    await context.read<NotesCubit>().deleteNote(widget.noteId);

    if (!mounted) return;

    final state = context.read<NotesCubit>().state;
    if (state is! NotesError) {
      context.pop();
    }
  }

  String _formatPreviewText(String text) {
    final lines = text.split('\n');
    final buffer = StringBuffer();
    bool inCodeBlock = false;

    for (final line in lines) {
      if (line.startsWith('```')) {
        inCodeBlock = !inCodeBlock;
        buffer.writeln(inCodeBlock ? '[Code Block]' : '');
        continue;
      }

      var formattedLine = line;
      if (!inCodeBlock) {
        if (line.startsWith('# ')) {
          formattedLine = line.substring(2);
        } else if (line.startsWith('## ')) {
          formattedLine = '   ${line.substring(3)}';
        } else if (line.startsWith('### ')) {
          formattedLine = '      ${line.substring(4)}';
        } else if (line.startsWith('- ')) {
          formattedLine = '• ${line.substring(2)}';
        } else if (line.startsWith('* ')) {
          formattedLine = '• ${line.substring(2)}';
        }
      }
      buffer.writeln(formattedLine);
    }

    return buffer.toString().isEmpty ? 'No content' : buffer.toString();
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour = date.hour > 12
        ? date.hour - 12
        : (date.hour == 0 ? 12 : date.hour);
    final amPm = date.hour >= 12 ? 'PM' : 'AM';
    final minute = date.minute.toString().padLeft(2, '0');
    return '${months[date.month - 1]} ${date.day}, ${date.year} at $hour:$minute $amPm';
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NotesCubit>().state;

    if (state is NotesInitial || state is NotesLoading) {
      return RizenScaffold(
        appBar: AppBar(title: const Text('Note Detail')),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: SkeletonCard(height: 200),
        ),
      );
    }

    if (state is NotesError) {
      return RizenScaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(PhosphorIconsBold.arrowLeft),
            onPressed: () => context.pop(),
          ),
          title: const Text('Note Detail'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                PhosphorIconsBold.warningCircle,
                color: AppColors.warning,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                state.message,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.warning),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              RizenButton(
                label: 'Retry',
                variant: RizenButtonVariant.secondary,
                onPressed: () =>
                    context.read<NotesCubit>().loadNote(widget.noteId),
              ),
            ],
          ),
        ),
      );
    }

    if (state is! NotesLoaded || state.selectedNote == null) {
      return const SizedBox.shrink();
    }

    final note = state.selectedNote!;

    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Note Detail'),
        actions: [
          IconButton(
            onPressed: () => SharePlus.instance.share(
              ShareParams(text: '${note.title}\n\n${note.content}'),
            ),
            icon: const Icon(PhosphorIconsBold.shareNetwork),
          ),
          IconButton(
            onPressed: () => context.push(AppRoutes.noteEdit(note.id)),
            icon: const Icon(PhosphorIconsBold.pencilSimple),
          ),
          IconButton(
            onPressed: _delete,
            icon: const Icon(PhosphorIconsBold.trash),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          Text(note.title, style: Theme.of(context).textTheme.headlineSmall),
          if (note.category != null) ...[
            const SizedBox(height: 8),
            _buildCategoryChip(note.category!),
          ],
          if (note.tags.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: note.tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.accent.withAlpha(76)),
                  ),
                  child: Text(
                    tag,
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: AppColors.accent),
                  ),
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 12),
          Text(
            _formatDate(note.loggedAt),
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
          ),
          if (note.updatedAt != null &&
              note.updatedAt!.difference(note.loggedAt).inMinutes > 1) ...[
            const SizedBox(height: 4),
            Text(
              'Updated ${_formatDate(note.updatedAt!)}',
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
            ),
          ],
          if (note.editHistory.isNotEmpty) ...[
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => _showEditHistory(context, note.editHistory),
              icon: const Icon(PhosphorIconsBold.clock, size: 16),
              label: Text('${note.editHistory.length} edits'),
            ),
          ],
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground.withAlpha(76),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: SelectableText(
              _formatPreviewText(note.content),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(NoteCategory category) {
    final colors = {
      NoteCategory.reflection: const Color(0xFF4CAF50),
      NoteCategory.gratitude: const Color(0xFFFFB300),
      NoteCategory.brainDump: const Color(0xFF42A5F5),
      NoteCategory.insight: const Color(0xFFAB47BC),
      NoteCategory.custom: const Color(0xFF78909C),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors[category]!.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors[category]!),
      ),
      child: Text(
        category.name,
        style: TextStyle(
          fontSize: 12,
          color: colors[category],
        ),
      ),
    );
  }

  void _showEditHistory(BuildContext context, List<DateTime> history) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Edit History',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...history.map((date) => ListTile(
                leading: const Icon(PhosphorIconsBold.clock),
                title: Text(_formatDate(date)),
              )),
        ],
      ),
    );
  }
}
