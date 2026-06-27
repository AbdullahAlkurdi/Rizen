import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../cubit/analytics_cubit.dart';

class DomainCorrelationPage extends StatelessWidget {
  const DomainCorrelationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsCubit, AnalyticsState>(
      builder: (context, state) {
        final domainHours = state is AnalyticsLoaded
            ? state.domainHoursThisWeek
            : <String, double>{};

        return FeatureScaffold(
          title: 'Domain Correlation',
          subtitle: 'Evaluating intersections between life pillars.',
          body: ListView(
            children: [
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hours This Week',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    if (domainHours.isEmpty)
                      const Text('No domain activity recorded this week.')
                    else
                      ...domainHours.entries.map((entry) {
                        final hours = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  entry.key.toUpperCase(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Text(
                                '${hours.toStringAsFixed(1)}h',
                                style: Theme.of(context).textTheme.titleMedium,
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
