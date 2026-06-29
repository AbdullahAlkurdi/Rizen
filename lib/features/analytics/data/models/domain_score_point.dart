class DomainScorePoint {
  const DomainScorePoint({
    required this.domain,
    required this.date,
    required this.score,
    required this.totalSessions,
    required this.totalMinutes,
  });

  final String domain;
  final DateTime date;
  final double score;
  final int totalSessions;
  final int totalMinutes;

  factory DomainScorePoint.fromJson(Map<String, dynamic> json) =>
      DomainScorePoint(
        domain: json['domain'] as String,
        date: DateTime.parse(json['date'] as String),
        score: (json['score'] as num).toDouble(),
        totalSessions: json['totalSessions'] as int,
        totalMinutes: json['totalMinutes'] as int,
      );

  Map<String, dynamic> toJson() => {
    'domain': domain,
    'date': date.toIso8601String(),
    'score': score,
    'totalSessions': totalSessions,
    'totalMinutes': totalMinutes,
  };

  DomainScorePoint copyWith({
    String? domain,
    DateTime? date,
    double? score,
    int? totalSessions,
    int? totalMinutes,
  }) {
    return DomainScorePoint(
      domain: domain ?? this.domain,
      date: date ?? this.date,
      score: score ?? this.score,
      totalSessions: totalSessions ?? this.totalSessions,
      totalMinutes: totalMinutes ?? this.totalMinutes,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DomainScorePoint &&
          runtimeType == other.runtimeType &&
          domain == other.domain &&
          date == other.date &&
          score == other.score &&
          totalSessions == other.totalSessions &&
          totalMinutes == other.totalMinutes;

  @override
  int get hashCode =>
      domain.hashCode ^ date.hashCode ^ score.hashCode ^ totalSessions.hashCode ^ totalMinutes.hashCode;
}
