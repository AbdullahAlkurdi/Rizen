import 'package:cloud_firestore/cloud_firestore.dart';

class DailyReviewSchedule {
  const DailyReviewSchedule({
    required this.uid,
    required this.enabled,
    required this.reviewHour,
    required this.reviewMinute,
    required this.nextReviewAt,
    this.lastPromptedAt,
  });

  final String uid;
  final bool enabled;
  final int reviewHour;
  final int reviewMinute;
  final DateTime nextReviewAt;
  final DateTime? lastPromptedAt;

  bool get isDue => enabled && !nextReviewAt.isAfter(DateTime.now());

  DailyReviewSchedule copyWith({
    bool? enabled,
    int? reviewHour,
    int? reviewMinute,
    DateTime? nextReviewAt,
    DateTime? lastPromptedAt,
  }) {
    return DailyReviewSchedule(
      uid: uid,
      enabled: enabled ?? this.enabled,
      reviewHour: reviewHour ?? this.reviewHour,
      reviewMinute: reviewMinute ?? this.reviewMinute,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      lastPromptedAt: lastPromptedAt ?? this.lastPromptedAt,
    );
  }

  factory DailyReviewSchedule.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return DailyReviewSchedule(
      uid: data['uid'] as String? ?? '',
      enabled: data['enabled'] as bool? ?? true,
      reviewHour: data['reviewHour'] as int? ?? 21,
      reviewMinute: data['reviewMinute'] as int? ?? 0,
      nextReviewAt: _dateTimeFromValue(data['nextReviewAt']),
      lastPromptedAt: data['lastPromptedAt'] == null
          ? null
          : _dateTimeFromValue(data['lastPromptedAt']),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'uid': uid,
    'enabled': enabled,
    'reviewHour': reviewHour,
    'reviewMinute': reviewMinute,
    'nextReviewAt': Timestamp.fromDate(nextReviewAt),
    'lastPromptedAt': lastPromptedAt == null
        ? null
        : Timestamp.fromDate(lastPromptedAt!),
  };
}

DateTime _dateTimeFromValue(Object? value) {
  if (value is Timestamp) return value.toDate();
  if (value is DateTime) return value;
  if (value is String) return DateTime.parse(value);
  return DateTime.now();
}
