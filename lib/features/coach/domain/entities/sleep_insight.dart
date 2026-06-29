class SleepInsight {
  const SleepInsight({
    required this.date,
    required this.bedResistanceMetric,
    required this.insight,
    required this.recommendation,
  });

  final DateTime date;
  final double bedResistanceMetric;
  final String insight;
  final String recommendation;
}
