import os

content = """import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/page_header.dart';
import '../cubit/home_cubit.dart';

class SleepAnalyticsPage extends StatelessWidget {
  const SleepAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final todaySleep = state is HomeLoaded ? state.todaySleepLog : null;
        final sleepPattern = state is HomeLoaded ? state.sleepWeekPattern : <double>[];

        final targetWake = todaySleep?.wakeTimeTarget;
        final actualWake = todaySleep?.sleepEnd;
        String delayLabel = '-';
        Color delayColor = AppColors.success;

        if (targetWake != null && actualWake != null) {
          final delayMinutes = targetWake.difference(actualWake).inMinutes;
          if (delayMinutes <= 0) {
            delayLabel = 'On time';
            delayColor = AppColors.success;
          } else if (delayMinutes <= 15) {
            delayLabel = '+' + delayMinutes.toString() + 'm';
            delayColor = Color(0xFF60A5FA);
          } else if (delayMinutes <= 45) {
            delayLabel = '+' + delayMinutes.toString() + 'm';
            delayColor = AppColors.warning;
          } else {
            delayLabel = '+' + delayMinutes.toString() + 'm';
            delayColor = AppColors.shadow;
          }
        }

        final bedResistance = todaySleep?.bedResistanceMetric ?? 0.0;
        final analysisNotes = todaySleep?.analysisNotes ?? 'No sleep log recorded yet.';

        return FeatureScaffold(
          title: 'Sleep & Discipline',
          body: ListView(
            children: [
              const PageHeader(
                title: 'Passive Tracking',
                subtitle: 'First phone unlock, wake timestamps, and Bed Resistance Metric.',
              ),
              const SizedBox(height: 20),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(PhosphorIconsBold.alarm, color: AppColors.accent),
                        const SizedBox(width: 10),
                        Text(
                          "Today's Wake Event",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _WakeStat(
                            label: 'Target',
                            value: targetWake != null
                                ? targetWake.hour.toString() + ':' + targetWake.minute.toString().padLeft(2, '0')
                                : '--:--',
                            color: AppColors.success,
                          ),
                        ),
                        Expanded(
                          child: _WakeStat(
                            label: 'Actual',
                            value: actualWake != null
                                ? actualWake.hour.toString() + ':' + actualWake.minute.toString().padLeft(2, '0')
                                : '--:--',
                            color: AppColors.warning,
                          ),
                        ),
                        Expanded(
                          child: _WakeStat(
                            label: 'Delay',
                            value: delayLabel,
                            color: delayColor,
                          ),
                        ),
                      ],
                    ),
                    if (todaySleep != null && todaySleep.confirmed != true)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: FilledButton.icon(
                          onPressed: () {
                            context.read<HomeCubit>().confirmSleepLog(todaySleep.id, true);
                          },
                          icon: const Icon(PhosphorIconsBold.check),
                          label: const Text('Confirm Sleep Log'),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            foregroundColor: AppColors.primaryBackground,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              GlassCard(
                gradient: LinearGradient(
                  colors: [
                    AppColors.warning.withValues(alpha: 0.15),
                    AppColors.cardBackground.withValues(alpha: 0.7),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bed Resistance Metric: ' + (bedResistance * 100).round().toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      analysisNotes,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: bedResistance,
                      backgroundColor: AppColors.glassFill,
                      color: AppColors.warning,
                      borderRadius: BorderRadius.circular(4),
                      minHeight: 8,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '7-Day Wake Pattern',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              GlassCard(
                child: SizedBox(
                  height: 140,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(7, (index) {
                      final heightFactor = sleepPattern.length > index ? sleepPattern[index] : 0.0;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 100 * heightFactor,
                                decoration: BoxDecoration(
                                  color: index == 5
                                      ? AppColors.accent
                                      : AppColors.accent.withValues(alpha: 0.4),
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
                                  style: Theme.of(context).textTheme.labelSmall),
                            ],
                          ),
                        ),
                      );
                    }),
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

class _WakeStat extends StatelessWidget {
  const _WakeStat({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        Text(value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color)),
      ],
    );
  }
}
"""

path = r'D:\work\rizen\lib\features\home\presentation\pages\sleep_analytics_page.dart'
with open(path, 'w', encoding='utf-8') as f:
    f.write(content)
print('done')
