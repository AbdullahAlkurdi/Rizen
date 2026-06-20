import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class RoutineHistoryPage extends StatelessWidget {
  const RoutineHistoryPage({super.key});

  static const _history = [
    _HistoryItem(
      'Morning Power v3',
      'June 18, 2026',
      '5h 45m',
      12,
      AppColors.accent,
    ),
    _HistoryItem(
      'Morning Power v2',
      'June 10, 2026',
      '5h 30m',
      8,
      Color(0xFF60A5FA),
    ),
    _HistoryItem(
      'Morning Power v1',
      'May 28, 2026',
      '4h 45m',
      5,
      AppColors.textMuted,
    ),
    _HistoryItem(
      'Exam Week Routine',
      'May 12, 2026',
      '7h 00m',
      3,
      Color(0xFF818CF8),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Routine History'),
      ),
      body: ListView(
        children: [
          const PageHeader(
            title: 'Archival View',
            subtitle: 'Past routine iterations and version history.',
          ),
          const SizedBox(height: 20),
          ..._history.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                onTap: () {},
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: item.color.withValues(alpha: 0.15),
                        borderRadius: AppTheme.cardRadius,
                      ),
                      child: Icon(
                        PhosphorIconsBold.clockCounterClockwise,
                        color: item.color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '${item.date} · ${item.duration} · ${item.streak}d active',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      PhosphorIconsBold.caretRight,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryItem {
  const _HistoryItem(
    this.title,
    this.date,
    this.duration,
    this.streak,
    this.color,
  );

  final String title;
  final String date;
  final String duration;
  final int streak;
  final Color color;
}
