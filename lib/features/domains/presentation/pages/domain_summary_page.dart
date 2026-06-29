import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../core/services/tutorial_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/tutorials/rizen_tutorial.dart';
import '../../../../core/tutorials/tutorial_mixin.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../cubit/domain_logs_cubit.dart';
import '../../data/domain_catalog.dart';
import '../../data/models/domain_log_model.dart';

class DomainSummaryPage extends StatefulWidget {
  const DomainSummaryPage({super.key});

  @override
  State<DomainSummaryPage> createState() => _DomainSummaryPageState();
}

class _DomainSummaryPageState extends State<DomainSummaryPage>
    with TutorialMixin {
  @override
  String get tutorialKey => TutorialService.keys['domain_summary']!;

  @override
  List<TargetFocus> buildTargets() => RizenTutorial.domainSummary(_tutorialKeys);

  final Map<String, GlobalKey> _tutorialKeys = {
    'chart': GlobalKey(),
    'log': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) maybeShowTutorial();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DomainLogsCubit, DomainLogsState>(
      builder: (context, state) {
        final weeklySummary = state is DomainLogsLoaded ? state.weeklySummary : <String, double>{};
        final todayLogs = state is DomainLogsLoaded ? state.todayLogs : <DomainLog>[];
        final streaks = <String, int>{};
        for (final domain in DomainCatalog.all) {
          streaks[domain.routeId] = state is DomainLogsLoaded ? state.summary.streak : 0;
        }

        return RizenScaffold(
          appBar: AppBar(
            title: const Text('Domain Summary'),
            actions: [
              IconButton(
                onPressed: showTutorialNow,
                icon: const Icon(PhosphorIconsBold.question),
                color: const Color(0xFF9CA3AF),
                tooltip: 'Help',
              ),
            ],
          ),
          extendBody: true,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          body: ListView(
            children: [
              const PageHeader(
                title: 'Domain Summary',
                subtitle: 'Weekly overview across all life pillars.',
              ),
              const SizedBox(height: 20),
              Container(
                key: _tutorialKeys['chart'] as Key,
                child: GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weekly Hours',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 220,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: DomainCatalog.all.fold<double>(0, (max, d) {
                              final hours = weeklySummary[d.routeId] ?? 0;
                              return hours > max ? hours : max;
                            }).clamp(1.0, 100.0) * 1.2,
                            barTouchData: BarTouchData(enabled: false),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    final index = value.toInt();
                                    if (index < 0 || index >= DomainCatalog.all.length) return const Text('');
                                    final name = DomainCatalog.all[index].name;
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        name.length > 5 ? name.substring(0, 5) : name,
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            barGroups: DomainCatalog.all.map((domain) {
                              final hours = weeklySummary[domain.routeId] ?? 0;
                              return BarChartGroupData(
                                x: DomainCatalog.all.indexOf(domain),
                                barRods: [
                                  BarChartRodData(
                                    toY: hours,
                                    color: domain.color,
                                    width: 16,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                key: _tutorialKeys['log'] as Key,
                child: GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Logs",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      if (state is! DomainLogsLoaded)
                        const Text('Loading daily logs...')
                      else if (state.todayLogs.isEmpty)
                        const Text('No activity logged today.')
                      else
                        ...todayLogs.map((log) {
                          final domain = DomainCatalog.byId(log.domainId);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: domain.color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    domain.name,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                Text(
                                  '${log.duration} min',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodySmall,
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.glassFill,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Intensity ${log.intensity}',
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Domain Streaks',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    ...DomainCatalog.all.map((domain) {
                      final streak = streaks[domain.routeId] ?? 0;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Icon(domain.icon, color: domain.color, size: 18),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                domain.name,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Text(
                              '$streak days',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}