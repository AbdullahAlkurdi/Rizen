import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'rizen_scaffold.dart';

class FeatureScaffold extends StatelessWidget {
  const FeatureScaffold({
    super.key,
    required this.title,
    required this.body,
    this.subtitle,
    this.actions,
    this.floatingActionButton,
    this.showBack = true,
    this.bottomPadding = 100,
  });

  final String title;
  final String? subtitle;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool showBack;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      extendBody: true,
      padding: EdgeInsets.fromLTRB(20, 12, 20, bottomPadding),
      floatingActionButton: floatingActionButton,
      appBar: AppBar(
        leading: showBack
            ? IconButton(
                icon: Icon(PhosphorIconsBold.arrowLeft),
                onPressed: () => context.pop(),
              )
            : null,
        title: Text(title),
        actions: actions,
      ),
      body: subtitle == null
          ? body
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 20),
                Expanded(child: body),
              ],
            ),
    );
  }
}
