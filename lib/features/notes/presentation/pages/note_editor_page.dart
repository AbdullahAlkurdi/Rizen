import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../domain/entities/note_category.dart';
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
  bool _isPinned = false;
  DateTime? _reminderAt;
  NoteCategory? _selectedCategory;
  Timer? _autoSaveTimer;

  @override
  void initState() {
    super.initState();
    if (widget.noteId != null) {
      context.read<NotesCubit>().loadNote(widget.noteId!);
    }
    _contentController.addListener(_onContentChanged);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagsController.dispose();
    _moodController.dispose();
    _autoSaveTimer?.cancel();
    super.dispose();
  }

  void _onContentChanged() {
    _autoSaveTimer?.cancel();
    if (widget.noteId != null && !_isSaving) {
      _autoSaveTimer = Timer(const Duration(seconds: 10), () {
        if (_titleController.text.isNotEmpty || _contentController.text.isNotEmpty) {
          _save(autoSave: true);
        }
      });
    }
  }

  void _populateFromNote(Note note) {
    if (_populated) return;
    _populated = true;
    _titleController.text = note.title;
    _contentController.text = note.content;
    _tagsController.text = note.tags.join(', ');
    _moodController.text = note.mood;
    _isPinned = note.isPinned;
    _reminderAt = note.reminderAt;
    _selectedCategory = note.category;
  }

  Future<void> _save({bool autoSave = false}) async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    if (title.isEmpty && content.isEmpty) return;

    if (!autoSave) {
      setState(() => _isSaving = true);
    }

    final tags = _tagsController.text
        .split(',')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();

    final moodText = _moodController.text.trim();
    final mood = moodText.isEmpty ? 'neutral' : moodText;

    final now = DateTime.now();

    if (widget.noteId != null) {
      await context.read<NotesCubit>().updateNote(
            Note(
              id: widget.noteId!,
              uid: '',
              title: title,
              content: content,
              tags: tags,
              mood: mood,
              loggedAt: now,
              updatedAt: now,
              category: _selectedCategory,
              isPinned: _isPinned,
              reminderAt: _reminderAt,
              editHistory: [DateTime.now()],
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
              loggedAt: now,
              category: _selectedCategory,
              isPinned: _isPinned,
              reminderAt: _reminderAt,
            ),
          );
    }

    if (!mounted) return;

    final state = context.read<NotesCubit>().state;
    if (!autoSave && state is! NotesError) {
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

  int get _wordCount {
    final words = _contentController.text.trim().split(RegExp(r'\s+'));
    return words.isEmpty ? 0 : words.length;
  }

  int get _charCount => _contentController.text.length;

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
            onPressed: _isSaving ? null : () => _save(),
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
        padding: const EdgeInsets.all(16),
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
          DropdownButtonFormField<NoteCategory>(
            initialValue: _selectedCategory,
            decoration: const InputDecoration(
              labelText: 'Category',
              prefixIcon: Icon(PhosphorIconsBold.folder),
            ),
            items: NoteCategory.values.map((cat) {
              return DropdownMenuItem(
                value: cat,
                child: Text(cat.name),
              );
            }).toList(),
            onChanged: (cat) => setState(() => _selectedCategory = cat),
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
          SwitchListTile(
            title: const Text('Pinned'),
            subtitle: const Text('Show at top of notes list'),
            value: _isPinned,
            onChanged: (val) => setState(() => _isPinned = val),
            secondary: const Icon(PhosphorIconsBold.pushPin),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(PhosphorIconsBold.bell),
            title: Text(
              _reminderAt == null
                  ? 'Set Reminder'
                  : 'Reminder: ${_formatTime(_reminderAt!)}',
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (date == null) return;
              // ignore: use_build_context_synchronously
              final time = await showTimePicker(
                // ignore: use_build_context_synchronously
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (time == null) return;
              if (!mounted) return;
              setState(() {
                _reminderAt = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  time.hour,
                  time.minute,
                );
              });
            },
            trailing: _reminderAt != null
                ? IconButton(
                    icon: const Icon(PhosphorIconsBold.x),
                    onPressed: () => setState(() => _reminderAt = null),
                  )
                : null,
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
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '$_wordCount words • $_charCount characters',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.textMuted,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          RizenButton(
            label: widget.noteId != null ? 'Save Changes' : 'Save Note',
            icon: PhosphorIconsBold.check,
            isLoading: _isSaving,
            onPressed: _isSaving ? null : () => _save(),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime date) {
    final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final amPm = date.hour >= 12 ? 'PM' : 'AM';
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute $amPm';
  }
}