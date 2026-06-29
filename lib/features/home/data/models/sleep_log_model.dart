import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sleep_log_model.freezed.dart';
part 'sleep_log_model.g.dart';

enum LogSource {
  detected,
  manual,
  corrected;

  String get label {
    switch (this) {
      case LogSource.detected:
        return 'Passive Detection';
      case LogSource.manual:
        return 'Manual Entry';
      case LogSource.corrected:
        return 'Corrected';
    }
  }
}

@freezed
class SleepLog with _$SleepLog {
  const SleepLog._();

  const factory SleepLog({
    required String id,
    required String uid,
    required DateTime sleepStart,
    required DateTime sleepEnd,
    DateTime? wakeTimeTarget,
    bool? confirmed,
    DateTime? confirmedAt,
    double? bedResistanceMetric,
    LogSource? source,
    @Default(false) bool isAnalysisReady,
    String? analysisNotes,
    DateTime? bedtime,
    DateTime? wakeTime,
    int? sleepMinutes,
    String? sleepQuality,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SleepLog;

  factory SleepLog.fromJson(Map<String, dynamic> json) =>
      _$SleepLogFromJson(json);

  factory SleepLog.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SleepLog(
      id: doc.id,
      uid: data['uid'] as String? ?? '',
      sleepStart: (data['sleepStart'] as Timestamp?)?.toDate() ?? DateTime.now(),
      sleepEnd: (data['sleepEnd'] as Timestamp?)?.toDate() ?? DateTime.now(),
      wakeTimeTarget: (data['wakeTimeTarget'] as Timestamp?)?.toDate(),
      confirmed: data['confirmed'] as bool?,
      confirmedAt: (data['confirmedAt'] as Timestamp?)?.toDate(),
      bedResistanceMetric: (data['bedResistanceMetric'] as num?)?.toDouble(),
      source: data['source'] != null
          ? LogSource.values.firstWhere(
              (e) => e.name == data['source'],
              orElse: () => LogSource.detected,
            )
          : null,
      isAnalysisReady: data['isAnalysisReady'] as bool? ?? false,
      analysisNotes: data['analysisNotes'] as String?,
      bedtime: (data['bedtime'] as Timestamp?)?.toDate(),
      wakeTime: (data['wakeTime'] as Timestamp?)?.toDate(),
      sleepMinutes: data['sleepMinutes'] as int?,
      sleepQuality: data['sleepQuality'] as String?,
      notes: data['notes'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    return {
      ...json,
      'sleepStart': Timestamp.fromDate(sleepStart),
      'sleepEnd': Timestamp.fromDate(sleepEnd),
      'wakeTimeTarget': wakeTimeTarget != null ? Timestamp.fromDate(wakeTimeTarget!) : null,
      'confirmedAt': confirmedAt != null ? Timestamp.fromDate(confirmedAt!) : null,
      'bedtime': bedtime != null ? Timestamp.fromDate(bedtime!) : null,
      'wakeTime': wakeTime != null ? Timestamp.fromDate(wakeTime!) : null,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
