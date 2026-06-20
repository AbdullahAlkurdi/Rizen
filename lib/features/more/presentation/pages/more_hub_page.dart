import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class MoreHubPage extends StatelessWidget {
  const MoreHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      extendBody: true,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      body: ListView(
        children: [
          const PageHeader(
            title: 'Explore RizenOS',
            subtitle: 'All layers of your Life Operating System.',
          ),
          const SizedBox(height: 20),
          _Section(
            title: 'Dashboard',
            items: [
              _HubItem(
                'Monthly Calendar',
                'Streak grid & consistency map',
                PhosphorIconsBold.calendar,
                AppRoutes.monthlyCalendar,
              ),
              _HubItem(
                'Notifications',
                'Alerts & systemic logs',
                PhosphorIconsBold.bell,
                AppRoutes.notifications,
              ),
              _HubItem(
                'Sleep Analytics',
                'Wake tracking & bed resistance',
                PhosphorIconsBold.moon,
                AppRoutes.sleepAnalytics,
              ),
            ],
          ),
          _Section(
            title: 'Life Pillars',
            items: [
              _HubItem(
                '7 Domain Trackers',
                'Sports, Study, Work & more',
                PhosphorIconsBold.columns,
                AppRoutes.domainsHub,
              ),
              _HubItem(
                'Habit Engine',
                'Good habits & shadow tracking',
                PhosphorIconsBold.arrowsClockwise,
                AppRoutes.habits,
              ),
              _HubItem(
                'Reward Store',
                'Unlock real-life pleasures',
                PhosphorIconsBold.gift,
                AppRoutes.rewardStore,
              ),
            ],
          ),
          _Section(
            title: 'Intelligence',
            items: [
              _HubItem(
                'AI Coach',
                'Briefings, chat & insights',
                PhosphorIconsBold.robot,
                AppRoutes.coach,
              ),
              _HubItem(
                'Notes & Reflections',
                'Journal, voice notes & search',
                PhosphorIconsBold.notebook,
                AppRoutes.notes,
              ),
              _HubItem(
                'Analytics & Growth',
                'Trends, burnout risk & export',
                PhosphorIconsBold.chartLineUp,
                AppRoutes.analytics,
              ),
            ],
          ),
          _Section(
            title: 'System',
            items: [
              _HubItem(
                'Profile & Settings',
                'Account, privacy & CLI access',
                PhosphorIconsBold.gear,
                AppRoutes.profile,
              ),
              _HubItem(
                'Support & Feedback',
                'Help, attribution & feedback',
                PhosphorIconsBold.lifebuoy,
                AppRoutes.support,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.items});

  final String title;
  final List<_HubItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 8),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        ...items.map(
          (item) => NavGlassTile(
            title: item.title,
            subtitle: item.subtitle,
            icon: item.icon,
            onTap: () => context.push(item.route),
          ),
        ),
      ],
    );
  }
}

class _HubItem {
  const _HubItem(this.title, this.subtitle, this.icon, this.route);

  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
}
