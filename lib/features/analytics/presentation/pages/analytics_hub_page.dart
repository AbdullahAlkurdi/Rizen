import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class AnalyticsHubPage extends StatelessWidget {
  const AnalyticsHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      extendBody: true,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      body: ListView(
        children: [
          const PageHeader(
            title: 'Analytics & Growth',
            subtitle:
                'Aggregated historical productivity and predictive trends.',
          ),
          const SizedBox(height: 20),
          GlassCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      PhosphorIconsFill.chartBar,
                      color: AppColors.accent,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Overall Score',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Text(
                  '76 / 100',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(color: AppColors.accent),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SizedBox(height: 12),
          NavGlassTile(
            title: 'Domain Correlation',
            subtitle: 'How life pillars influence each other.',
            icon: PhosphorIconsBold.chartLineUp,
            iconColor: Color(0xFF60A5FA),
            onTap: () => context.push(AppRoutes.domainCorrelation),
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Habit Trend Charts',
            subtitle: 'Temporal tracking of habit velocities.',
            icon: PhosphorIconsBold.chartLineUp,
            iconColor: Color(0xFF818CF8),
            onTap: () => context.push(AppRoutes.habitTrends),
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Growth Index & Burnout Risk',
            subtitle: 'Predictive indicators showing burnout windows.',
            icon: PhosphorIconsBold.activity,
            iconColor: AppColors.warning,
            onTap: () => context.push(AppRoutes.growthIndex),
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Data Export & Backup',
            subtitle: 'Privacy-focused data archival tool.',
            icon: PhosphorIconsBold.export,
            iconColor: Color(0xFF4ADE80),
            onTap: () => context.push(AppRoutes.dataExport),
          ),
        ],
      ),
    );
  }
}
