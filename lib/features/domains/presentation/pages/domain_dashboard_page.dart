import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../data/domain_catalog.dart';

class DomainDashboardPage extends StatelessWidget {
  const DomainDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final segments = GoRouterState.of(context).uri.pathSegments;
    final domainId = segments.length >= 3 ? segments[2] : 'sports';
    final domain = DomainCatalog.byId(domainId);

    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: Text(domain.name),
      ),
      body: ListView(
        children: [
          GlassCard(
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: domain.color.withValues(alpha: 0.15),
                    borderRadius: AppTheme.cardRadius,
                  ),
                  child: Icon(domain.icon, color: domain.color, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${domain.weeklyHours}h this week',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${domain.streak}-day streak · ${(domain.progress * 100).round()}% of goal',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: domain.progress,
            backgroundColor: AppColors.glassFill,
            color: domain.color,
            borderRadius: BorderRadius.circular(4),
            minHeight: 8,
          ),
          const SizedBox(height: 24),
          NavGlassTile(
            title: 'Log New Session',
            subtitle: 'Record a new activity entry.',
            icon: PhosphorIconsBold.plusCircle,
            iconColor: domain.color,
            onTap: () => context.push(AppRoutes.domainLog(domain.routeId)),
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Weekly Breakdown',
            subtitle: 'Day-by-day activity analysis.',
            icon: PhosphorIconsBold.chartBar,
            iconColor: domain.color,
            onTap: () {},
          ),
          const SizedBox(height: 10),
          NavGlassTile(
            title: 'Goal Settings',
            subtitle: 'Adjust weekly targets and thresholds.',
            icon: PhosphorIconsBold.target,
            iconColor: domain.color,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
