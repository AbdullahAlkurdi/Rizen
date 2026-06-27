import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../cubit/domain_logs_cubit.dart';
import '../../data/domain_catalog.dart';

class DomainTrackerView extends StatelessWidget {
  const DomainTrackerView({super.key, required this.domain});

  final DomainInfo domain;

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      extendBody: true,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      body: BlocBuilder<DomainLogsCubit, DomainLogsState>(
        builder: (context, state) {
          return ListView(
            children: [
              PageHeader(
                title: domain.name,
                subtitle: domain.subtitle,
              ),
              const SizedBox(height: 20),
              GlassCard(
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: domain.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(16),
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
              RizenButton(
                label: 'Log New Session',
                icon: PhosphorIconsBold.plusCircle,
                onPressed: () => context.push('/domains/log/${domain.routeId}'),
              ),
              const SizedBox(height: 10),
              if (state is DomainLogsLoaded && state.logs.isNotEmpty) ...[
                Text(
                  'Recent Logs',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ...state.logs.take(10).map((log) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: GlassCard(
                      child: ListTile(
                        leading: Icon(PhosphorIconsBold.clock, color: domain.color, size: 20),
                        title: Text('${log.duration} min · Intensity ${log.intensity}'),
                        subtitle: Text(
                          '${log.loggedAt.day}/${log.loggedAt.month}/${log.loggedAt.year}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: log.notes != null
                            ? Icon(PhosphorIconsBold.notepad, color: AppColors.textMuted, size: 18)
                            : null,
                      ),
                    ),
                  );
                }),
              ],
            ],
          );
        },
      ),
    );
  }
}
