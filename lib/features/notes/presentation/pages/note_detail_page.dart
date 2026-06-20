import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class NoteDetailPage extends StatelessWidget {
  const NoteDetailPage({super.key});

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
            onPressed: () => context.push(AppRoutes.noteEdit),
            icon: Icon(PhosphorIconsBold.pencilSimple),
          ),
          IconButton(onPressed: () {}, icon: Icon(PhosphorIconsBold.trash)),
        ],
      ),
      body: const Center(
        child: Text('Note detail viewer — placeholder for Markdown rendering.'),
      ),
    );
  }
}
