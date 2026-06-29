class HabitTrendPoint {
  const HabitTrendPoint({
    required this.habitId,
    required this.habitName,
    required this.date,
    required this.completionPct,
    required this.streakActive,
    required this.currentStreak,
  });

  final String habitId;
  final String habitName;
  final DateTime date;
  final double completionPct;
  final bool streakActive;
  final int currentStreak;

  factory HabitTrendPoint.fromJson(Map<String, dynamic> json) =>
      HabitTrendPoint(
        habitId: json['habitId'] as String,
        habitName: json['habitName'] as String,
        date: DateTime.parse(json['date'] as String),
        completionPct: (json['completionPct'] as num).toDouble(),
        streakActive: json['streakActive'] as bool,
        currentStreak: json['currentStreak'] as int,
      );

  Map<String, dynamic> toJson() => {
    'habitId': habitId,
    'habitName': habitName,
    'date': date.toIso8601String(),
    'completionPct': completionPct,
    'streakActive': streakActive,
    'currentStreak': currentStreak,
  };

  HabitTrendPoint copyWith({
    String? habitId,
    String? habitName,
    DateTime? date,
    double? completionPct,
    bool? streakActive,
    int? currentStreak,
  }) {
    return HabitTrendPoint(
      habitId: habitId ?? this.habitId,
      habitName: habitName ?? this.habitName,
      date: date ?? this.date,
      completionPct: completionPct ?? this.completionPct,
      streakActive: streakActive ?? this.streakActive,
      currentStreak: currentStreak ?? this.currentStreak,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitTrendPoint &&
          runtimeType == other.runtimeType &&
          habitId == other.habitId &&
          habitName == other.habitName &&
          date == other.date &&
          completionPct == other.completionPct &&
          streakActive == other.streakActive &&
          currentStreak == other.currentStreak;

  @override
  int get hashCode =>
      habitId.hashCode ^
      habitName.hashCode ^
      date.hashCode ^
      completionPct.hashCode ^
      streakActive.hashCode ^
      currentStreak.hashCode;
}
