import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class NoteDetailPage extends StatelessWidget {
  const NoteDetailPage({super.key, required this.noteId});

  final String noteId;

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
        }
      }
      buffer.writeln(formattedLine);
    }

    return buffer.toString().isEmpty ? 'No content' : buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Note Detail'),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.noteEdit(noteId)),
            icon: Icon(PhosphorIconsBold.pencilSimple),
          ),
          IconButton(onPressed: () {}, icon: Icon(PhosphorIconsBold.trash)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          Text(
            'Note Title',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: SelectableText(
              _formatPreviewText(''),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
