import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';

class RoutineTimeBlockEditorPage extends StatelessWidget {
  const RoutineTimeBlockEditorPage({super.key});

  static final _blocks = List.generate(
    5,
    (i) => _TimeBlock(
      title: ['Fajr', 'Deep Coding', 'Breakfast', 'Work Block', 'Review'][i],
      start: ['6:00 AM', '6:30 AM', '8:00 AM', '8:45 AM', '11:45 AM'][i],
      end: ['6:20 AM', '8:00 AM', '8:45 AM', '11:45 AM', '12:15 PM'][i],
      color: [
        AppColors.warning,
        Color(0xFF60A5FA),
        Color(0xFFFB923C),
        Color(0xFF38BDF8),
        AppColors.accent,
      ][i],
      icon: [
        PhosphorIconsBold.sunHorizon,
        PhosphorIconsBold.code,
        PhosphorIconsBold.bowlFood,
        PhosphorIconsBold.briefcase,
        PhosphorIconsBold.checkCircle,
      ][i],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Time-Block Editor',
      subtitle: 'Drag blocks to reorganize your daily timeline.',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(PhosphorIconsBold.plus),
        label: Text('Add Block'),
      ),
      body: ListView(
        children: [
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Timeline',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                ..._blocks.asMap().entries.map((entry) {
                  final index = entry.key;
                  final block = entry.value;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: block.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          if (index < _blocks.length - 1)
                            Container(
                              width: 2,
                              height: 48,
                              color: AppColors.glassBorder,
                            ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: GlassCard(
                            onTap: () {},
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            child: Row(
                              children: [
                                Icon(block.icon, color: block.color, size: 20),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        block.title,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      ),
                                      Text(
                                        '${block.start} — ${block.end}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  PhosphorIconsBold.listDashes,
                                  color: AppColors.textMuted,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeBlock {
  const _TimeBlock({
    required this.title,
    required this.start,
    required this.end,
    required this.color,
    required this.icon,
  });

  final String title;
  final String start;
  final String end;
  final Color color;
  final IconData icon;
}
