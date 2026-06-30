import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../data/models/sleep_log_model.dart';
import '../cubit/sleep_cubit.dart';
import '../cubit/sleep_state.dart';

String _formatTime(DateTime? time) {
  if (time == null) return '--:--';
  return DateFormat('h:mm a').format(time);
}

class SleepAnalyticsPage extends StatelessWidget {
  const SleepAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SleepCubit(
        repository: context.read(),
        sleepDetectorService: context.read(),
        sleepTrackingService: context.read(),
      )..loadTodaySleepData(),
      child: const SleepAnalyticsView(),
    );
  }
}

class SleepAnalyticsView extends StatelessWidget {
  const SleepAnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SleepCubit, SleepState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sleep & Discipline'),
          ),
          body: state is SleepLoading
              ? const _LoadingView()
              : state is SleepLoaded
                  ? _LoadedView(state: state)
                  : state is SleepError
                      ? _ErrorView(message: state.message, onRetry: state.onRetry)
                      : const Center(child: Text('No data')),
        );
      },
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        SkeletonCard(height: 160),
        SizedBox(height: 16),
        SkeletonCard(height: 160),
        SizedBox(height: 16),
        SkeletonBarChart(barCount: 7),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(PhosphorIconsBold.warningCircle, color: const Color(0xFFE94560), size: 48),
            const SizedBox(height: 16),
            Text(message, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            TextButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  const _LoadedView({required this.state});

  final SleepLoaded state;

  Color _getResistanceColor(double score) {
    if (score <= 20) return const Color(0xFF4ADE80);
    if (score <= 50) return const Color(0xFFFBBF24);
    return const Color(0xFFE94560);
  }

  String _getResistanceLabel(double score) {
    if (score <= 20) return 'Low resistance';
    if (score <= 50) return 'Moderate resistance';
    return 'High resistance';
  }

  Color _getDelayColor(int delayMinutes) {
    if (delayMinutes <= 0) return const Color(0xFF4ADE80);
    if (delayMinutes <= 15) return const Color(0xFF60A5FA);
    if (delayMinutes <= 60) return const Color(0xFFFBBF24);
    return const Color(0xFFE94560);
  }

  String _getDelayLabel(int delayMinutes) {
    if (delayMinutes <= 0) return 'On time';
    return '+${delayMinutes}m';
  }

  @override
  Widget build(BuildContext context) {
    final todayLog = state.todayLog;
    final targetWakeTime = todayLog?.wakeTimeTarget;
    final actualWakeTime = todayLog?.sleepEnd;

    int? delayMinutes;
    if (targetWakeTime != null && actualWakeTime != null) {
      delayMinutes = targetWakeTime.difference(actualWakeTime).inMinutes;
    }

    final resistanceScore = todayLog?.bedResistanceMetric != null
        ? (todayLog!.bedResistanceMetric! * 100).clamp(0.0, 100.0)
        : null;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(PhosphorIconsBold.moon, color: const Color(0xFF0F3460)),
                  const SizedBox(width: 10),
                  Text(
                    "Today's Wake",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (todayLog != null && actualWakeTime != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatTime(actualWakeTime),
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: const Color(0xFFE94560),
                            height: 1,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'First unlock today',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    if (targetWakeTime != null && delayMinutes != null) ...[
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Target: ${_formatTime(targetWakeTime)}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          _DelayBadge(
                            label: _getDelayLabel(delayMinutes),
                            color: _getDelayColor(delayMinutes),
                          ),
                        ],
                      ),
                    ],
                  ],
                )
              else
                Column(
                  children: [
                    Icon(PhosphorIconsBold.moon, color: const Color(0xFFE94560).withValues(alpha: 0.5), size: 48),
                    const SizedBox(height: 12),
                    Text(
                      'Waiting for your first unlock today',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(PhosphorIconsBold.bed, color: const Color(0xFF0F3460)),
                  const SizedBox(width: 10),
                  Text(
                    'Bed Resistance',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (resistanceScore != null)
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: resistanceScore / 100,
                        strokeWidth: 12,
                        backgroundColor: const Color(0xFF16213E),
                        color: _getResistanceColor(resistanceScore),
                        strokeCap: StrokeCap.round,
                      ),
                      Text(
                        resistanceScore.round().toString(),
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              color: _getResistanceColor(resistanceScore),
                            ),
                      ),
                    ],
                  ),
                )
              else if (targetWakeTime == null)
                Column(
                  children: [
                    Text(
                      'Set a wake time in your routine to unlock this metric',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () => GoRouter.of(context).go(AppRoutes.spiritualSettings),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF0F3460),
                      ),
                      child: const Text('Set Wake Time'),
                    ),
                  ],
                )
              else
                const Text(
                  'No data yet',
                  style: TextStyle(color: Color(0xFF9CA3AF)),
                ),
              const SizedBox(height: 16),
              if (resistanceScore != null)
                Text(
                  _getResistanceLabel(resistanceScore),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              const SizedBox(height: 8),
              Text(
                'Measures how much your body resists waking up relative to your target. Lower is better — but this isn\'t about guilt, it\'s about awareness.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: const Color(0xFF9CA3AF)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'This Week',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        GlassCard(
          child: SizedBox(
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      barTouchData: BarTouchData(enabled: false),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(),
                        topTitles: const AxisTitles(),
                        rightTitles: const AxisTitles(),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                              return Text(
                                days[value.toInt() % 7],
                                style: Theme.of(context).textTheme.labelSmall,
                              );
                            },
                          ),
                        ),
                      ),
                      barGroups: _buildBarGroups(state.history),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (state.averageBedResistance > 0)
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            child: Text(
              '7-day average: ${state.averageBedResistance.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        if (state.averageBedResistance > 50) ...[
          const SizedBox(height: 16),
          GlassCard(
            borderColor: const Color(0xFFFBBF24),
            child: Row(
              children: [
                Icon(PhosphorIconsBold.lightning, color: const Color(0xFFFBBF24)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Your wake resistance has been high this week. Consider an earlier bedtime or activating Burnout Mode if you\'re feeling overwhelmed.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => GoRouter.of(context).go(AppRoutes.emergencyRecovery),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFFBBF24),
            ),
            child: const Text('Open Burnout Mode'),
          ),
        ],
      ],
    );
  }

  List<BarChartGroupData> _buildBarGroups(List<SleepLog> history) {
    final colors = [
      const Color(0xFF4ADE80),
      const Color(0xFFFBBF24),
      const Color(0xFFE94560),
    ];

    return history.asMap().entries.map((entry) {
      final index = entry.key;
      final log = entry.value;
      final score = log.bedResistanceMetric != null
          ? (log.bedResistanceMetric! * 100).clamp(0.0, 100.0)
          : 0.0;

      final colorIndex = score <= 20 ? 0 : (score <= 50 ? 1 : 2);

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: score,
            width: 20,
            color: colors[colorIndex],
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
  }
}

class _DelayBadge extends StatelessWidget {
  const _DelayBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
