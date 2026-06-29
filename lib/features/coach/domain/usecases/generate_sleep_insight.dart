import '../../../home/data/models/sleep_log_model.dart';
import '../entities/sleep_insight.dart';

class GenerateSleepInsightUseCase {
  SleepInsight? call(SleepLog? lastLog, List<SleepLog> weekLogs) {
    if (lastLog == null || weekLogs.isEmpty) return null;

    final now = DateTime.now();
    final weekMetrics = weekLogs
        .where((l) => l.bedResistanceMetric != null)
        .map((l) => l.bedResistanceMetric!)
        .toList();

    final avgResistance = weekMetrics.isNotEmpty
        ? weekMetrics.reduce((a, b) => a + b) / weekMetrics.length
        : 0.0;

    String insight;
    String recommendation;

    if (avgResistance > 0.4) {
      insight = 'Your sleep resistance is high. This may affect your energy today.';
      recommendation = 'Try going to bed 15 minutes earlier and avoid screens 30 minutes before sleep.';
    } else if (avgResistance >= 0.2) {
      insight = 'Moderate sleep resistance. Consider a wind-down routine.';
      recommendation = 'Establish a consistent pre-sleep routine to lower resistance over time.';
    } else {
      insight = 'Great sleep consistency. Your body is recovering well.';
      recommendation = 'Keep your current sleep schedule — it\'s serving your goals.';
    }

    final poorQualityDays = weekLogs.where((l) => l.sleepQuality == 'poor').length;
    if (poorQualityDays >= 3) {
      insight += ' Sleep quality has been poor. Check your nighttime routine.';
    }

    return SleepInsight(
      date: now,
      bedResistanceMetric: avgResistance,
      insight: insight,
      recommendation: recommendation,
    );
  }
}
