import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class DailyReflectionPage extends StatelessWidget {
  const DailyReflectionPage({super.key});

  static const _prompts = [
    'What went well today?',
    'What challenged you?',
    'What would you do differently?',
    'How aligned was today with your long-term values?',
  ];

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Nightly Reflection'),
      ),
      body: ListView(
        children: [
          const PageHeader(
            title: 'Guided Cognitive Unload',
            subtitle: 'Answer honestly. No judgments — just clarity.',
          ),
          const SizedBox(height: 20),
          ..._prompts.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          PhosphorIconsBold.question,
                          color: AppColors.accent,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            p,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Your reflection...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          RizenButton(
            label: 'Save Reflection',
            icon: PhosphorIconsBold.check,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Reflection saved.')),
              );
            },
          ),
        ],
      ),
    );
  }
}
