import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../core/widgets/rizen_button.dart';

class CliAccessPage extends StatelessWidget {
  const CliAccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('CLI Access'),
      ),
      body: ListView(
        children: [
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      PhosphorIconsBold.terminalWindow,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Developer CLI',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Generate API credentials to use Rizen directly from your terminal.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBackground,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.glassBorder),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'RIZEN_AK_****_****_x7f2',
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: AppColors.textMuted,
                                fontFamily: 'monospace',
                              ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          PhosphorIconsBold.copy,
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Usage Examples',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                _CodeBlock('rizen status', 'Show current daily status'),
                _CodeBlock(
                  'rizen log coding --duration 2h',
                  'Log 2 hours of coding',
                ),
                _CodeBlock(
                  'rizen log study --duration 1h',
                  'Log 1 hour of study',
                ),
                _CodeBlock('rizen dashboard', 'Open web dashboard'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          RizenButton(
            label: 'Generate New Token',
            icon: PhosphorIconsBold.key,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock(this.command, this.description);

  final String command;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            PhosphorIconsBold.terminalWindow,
            color: AppColors.textMuted,
            size: 14,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  command,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontFamily: 'monospace',
                    color: AppColors.accent,
                  ),
                ),
                Text(description, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
