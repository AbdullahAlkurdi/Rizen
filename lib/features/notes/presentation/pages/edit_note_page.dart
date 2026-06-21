import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../data/notes_repository.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key, required this.noteId});

  final String noteId;

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late final NotesRepository _repository;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isSaving = false;
  bool _isLoading = true;
  bool _showPreview = false;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _repository = NotesRepository();
    _loadNote();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _loadNote() async {
    try {
      final note = await _repository.getNote(widget.noteId);
      if (note == null) {
        if (!mounted) return;
        setState(() {
          _error = 'Note not found';
          _isLoading = false;
        });
        return;
      }
      if (!mounted) return;
      setState(() {
        _titleController.text = note.title;
        _contentController.text = note.content;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    try {
      await _repository.updateNote(
        noteId: widget.noteId,
        title: _titleController.text,
        content: _contentController.text,
      );
      if (!mounted) return;
      context.pop();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isSaving = false;
      });
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
          formattedLine = '📌 ${line.substring(2)}';
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
    if (_isLoading) {
      return RizenScaffold(
        appBar: AppBar(
          title: const Text('Edit Note'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error.isNotEmpty) {
      return RizenScaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(PhosphorIconsBold.arrowLeft),
            onPressed: () => context.pop(),
          ),
          title: const Text('Edit Note'),
        ),
        body: Center(
          child: Text(_error, style: TextStyle(color: AppColors.warning)),
        ),
      );
    }

    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Edit Note'),
        actions: [
          IconButton(
            icon: Icon(
              _showPreview ? PhosphorIconsBold.pencilSimple : PhosphorIconsBold.eye,
              color: _showPreview ? AppColors.accent : AppColors.textMuted,
            ),
            onPressed: () => setState(() => _showPreview = !_showPreview),
          ),
          TextButton(
            onPressed: _isSaving ? null : _save,
            child: _isSaving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.textPrimary,
                    ),
                  )
                : const Text('Save'),
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
          if (_showPreview) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.glassBorder),
              ),
              child: SelectableText(
                _formatPreviewText(_contentController.text),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ] else ...[
            TextField(
              controller: _contentController,
              maxLines: null,
              minLines: 10,
              decoration: const InputDecoration(
                hintText: 'Start writing... Markdown supported.\n\n# Headings\n**bold** _italic_ `code`\n- Lists\n',
                border: OutlineInputBorder(),
              ),
            ),
          ],
          const SizedBox(height: 20),
          RizenButton(
            label: 'Save Changes',
            icon: PhosphorIconsBold.check,
            isLoading: _isSaving,
            onPressed: _isSaving ? null : _save,
          ),
          const SizedBox(height: 12),
          RizenButton(
            label: _showPreview ? 'Back to Editor' : 'Preview Markdown',
            icon: _showPreview ? PhosphorIconsBold.pencilSimple : PhosphorIconsBold.eye,
            variant: RizenButtonVariant.secondary,
            onPressed: () => setState(() => _showPreview = !_showPreview),
          ),
        ],
      ),
    );
  }
}