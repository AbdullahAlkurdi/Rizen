import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../cubit/domain_logs_cubit.dart';
import '../../data/domain_catalog.dart';

class DomainDashboardPage extends StatelessWidget {
  final String domainId;

  const DomainDashboardPage({super.key, required this.domainId});

  @override
  Widget build(BuildContext context) {
    final domain = DomainCatalog.byId(domainId);
    final state = context.watch<DomainLogsCubit>().state;

    return RizenScaffold(
      appBar: AppBar(title: Text(domain.name)),
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
                        '${state is DomainLogsLoaded ? state.summary.weeklyHours.toStringAsFixed(1) : '0.0'}h this week',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${state is DomainLogsLoaded ? state.summary.streak : 0}-day streak · ${(state is DomainLogsLoaded ? state.summary.progress : 0 * 100).round()}% of goal',
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
            value: state is DomainLogsLoaded ? state.summary.progress : 0,
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
          if (state is DomainLogsLoaded && state.logs.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Recent Logs',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8),
            ...state.logs.take(5).map((log) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: GlassCard(
                    child: ListTile(
                      leading: Icon(PhosphorIconsBold.clock,
                          color: domain.color, size: 20),
                      title: Text('${log.duration} min'),
                      subtitle: Text(
                        '${log.loggedAt.day}/${log.loggedAt.month}/${log.loggedAt.year}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing: log.notes != null
                          ? Icon(PhosphorIconsBold.notepad,
                              color: AppColors.textMuted, size: 18)
                          : null,
                    ),
                  ),
                )),
            const SizedBox(height: 10),
          ],
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
