import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../cubit/analytics_cubit.dart';
import '../cubit/analytics_state.dart';
import '../../data/models/analytics_period.dart';

class DataExportPage extends StatelessWidget {
  const DataExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsCubit, AnalyticsState>(
      builder: (context, state) {
        return RizenScaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(PhosphorIconsBold.arrowLeft),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text('Data Export & Backup'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              GlassCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(PhosphorIconsBold.shieldCheck, color: AppColors.success, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your data never leaves your device without your explicit action. Exports are generated locally.',
                        style: TextStyle(color: AppColors.textMuted),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _ExportCard(
                icon: const Icon(PhosphorIconsBold.fileJs, color: Color(0xFF60A5FA)),
                title: 'Export as JSON',
                subtitle: 'Machine-readable format. Good for developers and backups.',
                buttonLabel: 'Export JSON',
                onTap: () => _promptExport(context, 'json'),
              ),
              const SizedBox(height: 12),
              _ExportCard(
                icon: const Icon(PhosphorIconsBold.fileCsv, color: Color(0xFF4ADE80)),
                title: 'Export as CSV',
                subtitle: 'Open in Excel or Sheets. Good for manual review.',
                buttonLabel: 'Export CSV',
                onTap: () => _promptExport(context, 'csv'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  void _promptExport(BuildContext context, String format) {
    AnalyticsPeriod range = AnalyticsPeriod.month;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text('Select Range'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: AnalyticsPeriod.values.map((p) {
            return ListTile(
              title: Text(p.name.toUpperCase()),
              trailing: range == p ? const Icon(Icons.check, color: AppColors.accent, size: 20) : null,
              onTap: () {
                range = p;
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<AnalyticsCubit>().exportData(format);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
            child: Text('Export ${format.toUpperCase()}'),
          ),
        ],
      ),
    );
  }
}

class _ExportCard extends StatelessWidget {
  const _ExportCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    required this.onTap,
  });

  final Widget icon;
  final String title;
  final String subtitle;
  final String buttonLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: AppTheme.cardRadius,
            ),
            child: icon,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
            child: Text(buttonLabel),
          ),
        ],
      ),
    );
  }
}
