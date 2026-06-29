class CorrelationInsight {
  const CorrelationInsight({
    required this.domainA,
    required this.domainB,
    required this.correlationScore,
    required this.insight,
    required this.isPositive,
  });

  final String domainA;
  final String domainB;
  final double correlationScore;
  final String insight;
  final bool isPositive;

  factory CorrelationInsight.fromJson(Map<String, dynamic> json) =>
      CorrelationInsight(
        domainA: json['domainA'] as String,
        domainB: json['domainB'] as String,
        correlationScore: (json['correlationScore'] as num).toDouble(),
        insight: json['insight'] as String,
        isPositive: json['isPositive'] as bool,
      );

  Map<String, dynamic> toJson() => {
    'domainA': domainA,
    'domainB': domainB,
    'correlationScore': correlationScore,
    'insight': insight,
    'isPositive': isPositive,
  };

  CorrelationInsight copyWith({
    String? domainA,
    String? domainB,
    double? correlationScore,
    String? insight,
    bool? isPositive,
  }) {
    return CorrelationInsight(
      domainA: domainA ?? this.domainA,
      domainB: domainB ?? this.domainB,
      correlationScore: correlationScore ?? this.correlationScore,
      insight: insight ?? this.insight,
      isPositive: isPositive ?? this.isPositive,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CorrelationInsight &&
          runtimeType == other.runtimeType &&
          domainA == other.domainA &&
          domainB == other.domainB &&
          correlationScore == other.correlationScore &&
          insight == other.insight &&
          isPositive == other.isPositive;

  @override
  int get hashCode =>
      domainA.hashCode ^
      domainB.hashCode ^
      correlationScore.hashCode ^
      insight.hashCode ^
      isPositive.hashCode;
}
