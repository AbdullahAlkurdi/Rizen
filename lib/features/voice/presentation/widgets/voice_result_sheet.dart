import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/services/voice_log_orchestrator.dart';

class VoiceResultSheet extends StatelessWidget {
  const VoiceResultSheet({
    super.key,
    required this.summary,
    required this.transcript,
  });

  final VoiceLogSummary summary;
  final String transcript;

  @override
  Widget build(BuildContext context) {
    final hasUpdates =
        summary.domainLogsCreated > 0 ||
        summary.habitsUpdated > 0 ||
        summary.todosUpdated > 0 ||
        summary.reflectionSaved;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You said',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transcript,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                if (hasUpdates) ...[
                  Text(
                    'What was updated',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildUpdatesList(context),
                  const SizedBox(height: 16),
                ],
                if (summary.unmatched.isNotEmpty) ...[
                  Text(
                    "Couldn't match",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.warning,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...summary.unmatched.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIconsFill.warningCircle,
                            color: AppColors.warning,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You can log these manually',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => context.go('/home'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textPrimary,
                          side: const BorderSide(color: AppColors.glassBorder),
                        ),
                        child: const Text('Log manually'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.accent,
                        ),
                        child: const Text('Done'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdatesList(BuildContext context) {
    final items = <String>[];

    if (summary.domainLogsCreated > 0) {
      items.add('Logged ${summary.domainLogsCreated} domain session(s)');
    }
    if (summary.habitsUpdated > 0) {
      items.add('Updated ${summary.habitsUpdated} habit(s)');
    }
    if (summary.todosUpdated > 0) {
      items.add('Checked ${summary.todosUpdated} todo item(s)');
    }
    if (summary.reflectionSaved) {
      items.add('Saved voice reflection');
    }
    if (summary.sleepNote != null) {
      items.add('Logged sleep note');
    }

    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Icon(
                    PhosphorIconsFill.checkCircle,
                    color: AppColors.success,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  static Future<void> show(BuildContext context, VoiceLogSummary summary, String transcript) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => VoiceResultSheet(summary: summary, transcript: transcript),
    );
  }
}
