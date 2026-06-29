import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../cubit/notes_cubit.dart';
import '../../data/models/note_model.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key, this.noteId});

  final String? noteId;

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _tagsController = TextEditingController();
  final _moodController = TextEditingController();
  bool _isSaving = false;
  bool _showPreview = false;
  bool _populated = false;

  @override
  void initState() {
    super.initState();
    if (widget.noteId != null) {
      context.read<NotesCubit>().loadNote(widget.noteId!);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagsController.dispose();
    _moodController.dispose();
    super.dispose();
  }

  void _populateFromNote(Note note) {
    if (_populated) return;
    _populated = true;
    _titleController.text = note.title;
    _contentController.text = note.content;
    _tagsController.text = note.tags.join(', ');
    _moodController.text = note.mood;
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    if (title.isEmpty && content.isEmpty) return;

    setState(() => _isSaving = true);

    final tags = _tagsController.text
        .split(',')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();

final moodText = _moodController.text.trim();
    final mood = moodText.isEmpty ? 'neutral' : moodText;

    if (widget.noteId != null) {
      await context.read<NotesCubit>().updateNote(
            Note(
              id: widget.noteId!,
              uid: '',
              title: title,
              content: content,
              tags: tags,
              mood: mood,
              loggedAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );
    } else {
      await context.read<NotesCubit>().createNote(
            Note(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              uid: '',
              title: title,
              content: content,
              tags: tags,
              mood: mood,
              loggedAt: DateTime.now(),
            ),
          );
    }

    if (!mounted) return;

    final state = context.read<NotesCubit>().state;
    if (state is NotesError) {
      setState(() => _isSaving = false);
    } else {
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
        } else if (line.startsWith('**') && line.endsWith('**')) {
          formattedLine = line.substring(2, line.length - 2);
        }
      }
      buffer.writeln(formattedLine);
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NotesCubit>().state;

    if (widget.noteId != null && (state is NotesInitial || state is NotesLoading)) {
      return RizenScaffold(
        appBar: AppBar(title: Text(widget.noteId != null ? 'Edit Note' : 'Create Note')),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SkeletonCard(height: 60),
              SizedBox(height: 16),
              SkeletonLine(height: 16),
              SizedBox(height: 12),
              SkeletonLine(height: 16),
              SizedBox(height: 12),
              SkeletonLine(height: 16),
            ],
          ),
        ),
      );
    }

    if (widget.noteId != null && state is NotesError) {
      return RizenScaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(PhosphorIconsBold.arrowLeft),
            onPressed: () => context.pop(),
          ),
          title: const Text('Edit Note'),
        ),
        body: Center(
          child: Text(
            state.message,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      );
    }

    if (widget.noteId != null && state is! NotesLoaded) {
      return RizenScaffold(
        appBar: AppBar(title: const Text('Edit Note')),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SkeletonCard(height: 60),
              SizedBox(height: 16),
              SkeletonLine(height: 16),
              SizedBox(height: 12),
              SkeletonLine(height: 16),
            ],
          ),
        ),
      );
    }

    if (widget.noteId != null && state is NotesLoaded) {
      final note = state.selectedNote!;
      _populateFromNote(note);
    }

    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: Text(widget.noteId != null ? 'Edit Note' : 'Create Note'),
        actions: [
          IconButton(
            icon: Icon(
              _showPreview
                  ? PhosphorIconsBold.pencilSimple
                  : PhosphorIconsBold.eye,
            ),
            onPressed: () => setState(() => _showPreview = !_showPreview),
          ),
          TextButton(
            onPressed: _isSaving ? null : _save,
            child: _isSaving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(widget.noteId != null ? 'Save' : 'Create'),
          ),
        ],
      ),
      body: ListView(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'Note title',
              prefixIcon: Icon(Icons.edit_outlined),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _tagsController,
            decoration: const InputDecoration(
              labelText: 'Tags',
              hintText: 'comma, separated, tags',
              prefixIcon: Icon(PhosphorIconsBold.tag),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _moodController,
            decoration: const InputDecoration(
              labelText: 'Mood',
              hintText: 'happy, sad, anxious, grateful...',
              prefixIcon: Icon(PhosphorIconsBold.smiley),
            ),
          ),
          const SizedBox(height: 16),
          if (_showPreview)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground.withAlpha(76),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.glassBorder),
              ),
              child: SelectableText(
                _formatPreviewText(_contentController.text),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          else
            TextField(
              controller: _contentController,
              maxLines: null,
              minLines: 10,
              decoration: const InputDecoration(
                hintText: 'Start writing... Markdown supported.',
                border: OutlineInputBorder(),
              ),
            ),
          const SizedBox(height: 20),
          RizenButton(
            label: widget.noteId != null ? 'Save Changes' : 'Save Note',
            icon: PhosphorIconsBold.check,
            isLoading: _isSaving,
            onPressed: _isSaving ? null : _save,
          ),
          const SizedBox(height: 12),
          RizenButton(
            label: _showPreview ? 'Back to Editor' : 'Preview Markdown',
            icon: _showPreview
                ? PhosphorIconsBold.pencilSimple
                : PhosphorIconsBold.eye,
            variant: RizenButtonVariant.secondary,
            onPressed: () => setState(() => _showPreview = !_showPreview),
          ),
        ],
      ),
    );
  }
}
