enum BurnoutRisk { low, moderate, high, critical }

class GrowthIndex {
  const GrowthIndex({
    required this.overallScore,
    required this.habitScore,
    required this.domainScore,
    required this.todoScore,
    required this.shadowPenalty,
    required this.burnoutRisk,
    required this.burnoutReason,
    required this.calculatedAt,
  });

  final double overallScore;
  final double habitScore;
  final double domainScore;
  final double todoScore;
  final double shadowPenalty;
  final BurnoutRisk burnoutRisk;
  final String burnoutReason;
  final DateTime calculatedAt;

  factory GrowthIndex.fromJson(Map<String, dynamic> json) => GrowthIndex(
    overallScore: (json['overallScore'] as num).toDouble(),
    habitScore: (json['habitScore'] as num).toDouble(),
    domainScore: (json['domainScore'] as num).toDouble(),
    todoScore: (json['todoScore'] as num).toDouble(),
    shadowPenalty: (json['shadowPenalty'] as num).toDouble(),
    burnoutRisk: BurnoutRisk.values.firstWhere(
      (e) => e.name == json['burnoutRisk'],
      orElse: () => BurnoutRisk.low,
    ),
    burnoutReason: json['burnoutReason'] as String,
    calculatedAt: DateTime.parse(json['calculatedAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'overallScore': overallScore,
    'habitScore': habitScore,
    'domainScore': domainScore,
    'todoScore': todoScore,
    'shadowPenalty': shadowPenalty,
    'burnoutRisk': burnoutRisk.name,
    'burnoutReason': burnoutReason,
    'calculatedAt': calculatedAt.toIso8601String(),
  };

  GrowthIndex copyWith({
    double? overallScore,
    double? habitScore,
    double? domainScore,
    double? todoScore,
    double? shadowPenalty,
    BurnoutRisk? burnoutRisk,
    String? burnoutReason,
    DateTime? calculatedAt,
  }) {
    return GrowthIndex(
      overallScore: overallScore ?? this.overallScore,
      habitScore: habitScore ?? this.habitScore,
      domainScore: domainScore ?? this.domainScore,
      todoScore: todoScore ?? this.todoScore,
      shadowPenalty: shadowPenalty ?? this.shadowPenalty,
      burnoutRisk: burnoutRisk ?? this.burnoutRisk,
      burnoutReason: burnoutReason ?? this.burnoutReason,
      calculatedAt: calculatedAt ?? this.calculatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GrowthIndex &&
          runtimeType == other.runtimeType &&
          overallScore == other.overallScore &&
          habitScore == other.habitScore &&
          domainScore == other.domainScore &&
          todoScore == other.todoScore &&
          shadowPenalty == other.shadowPenalty &&
          burnoutRisk == other.burnoutRisk &&
          burnoutReason == other.burnoutReason &&
          calculatedAt == other.calculatedAt;

  @override
  int get hashCode =>
      overallScore.hashCode ^
      habitScore.hashCode ^
      domainScore.hashCode ^
      todoScore.hashCode ^
      shadowPenalty.hashCode ^
      burnoutRisk.hashCode ^
      burnoutReason.hashCode ^
      calculatedAt.hashCode;
}
