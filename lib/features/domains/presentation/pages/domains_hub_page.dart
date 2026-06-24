import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../data/domain_catalog.dart';
import '../cubit/domain_logs_cubit.dart';

class DomainsHubPage extends StatelessWidget {
  const DomainsHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DomainLogsCubit, DomainLogsState>(
      builder: (context, state) {
        return RizenScaffold(
          extendBody: true,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          body: ListView(
            children: [
              const PageHeader(
                title: '7 Domain Trackers',
                subtitle: 'Deep logging and analytics for every life pillar.',
              ),
              const SizedBox(height: 20),
              if (state is DomainLogsLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                ),
              if (state is DomainLogsError)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Error: ${state.message}',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ...DomainCatalog.all.map(
                (domain) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: NavGlassTile(
                    title: domain.name,
                    subtitle: state is DomainLogsLoaded
                        ? '${state.summary.weeklyHours.toStringAsFixed(1)}h this week · ${state.summary.streak}d streak'
                        : '${domain.weeklyHours}h this week · ${domain.streak}d streak',
                    icon: domain.icon,
                    iconColor: domain.color,
                    onTap: () =>
                        context.push(AppRoutes.domainDashboard(domain.routeId)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
