import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../core/widgets/rizen_button.dart';

class DataExportPage extends StatelessWidget {
  const DataExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Data Export & Backup'),
      ),
      body: ListView(
        children: [
          const PageHeader(
            title: 'Secure Data Export',
            subtitle: 'Privacy-focused archival tool for your entire Life OS.',
          ),
          const SizedBox(height: 20),
          ...List.generate(4, (i) {
            final exports = [
              (
                'Full Backup',
                'All domains, habits, notes, and settings.',
                AppColors.accent,
                PhosphorIconsBold.database,
              ),
              (
                'Habits Only',
                'Habit history and streak data.',
                AppColors.success,
                PhosphorIconsBold.arrowsClockwise,
              ),
              (
                'Analytics Report',
                'Aggregated trends and insights.',
                Color(0xFF60A5FA),
                PhosphorIconsBold.chartPieSlice,
              ),
              (
                'Notes Archive',
                'All journal entries and reflections.',
                Color(0xFF818CF8),
                PhosphorIconsBold.notebook,
              ),
            ][i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                onTap: () {},
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: exports.$3.withValues(alpha: 0.15),
                        borderRadius: AppTheme.cardRadius,
                      ),
                      child: Icon(exports.$4, color: exports.$3, size: 20),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exports.$1,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            exports.$2,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      PhosphorIconsBold.downloadSimple,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 24),
          RizenButton(
            label: 'Schedule Auto-Backup',
            variant: RizenButtonVariant.secondary,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
