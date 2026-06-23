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
  const factory SleepLog({
    required String id,
    required String uid,
    required DateTime sleepStart,
    required DateTime sleepEnd,
    DateTime? wakeTimeTarget,
    bool? confirmed,
    DateTime? confirmedAt,
    double? bedResistanceMetric,
    @Default(LogSource.detected) LogSource source,
    @Default(false) bool isAnalysisReady,
    String? analysisNotes,
  }) = _SleepLog;

  factory SleepLog.fromJson(Map<String, dynamic> json) => _$SleepLogFromJson(json);

  factory SleepLog.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final sourceStr = data['source'] as String? ?? 'detected';
    return SleepLog(
      id: doc.id,
      uid: data['uid'] as String? ?? '',
      sleepStart: (data['sleepStart'] as Timestamp?)?.toDate() ?? DateTime.now(),
      sleepEnd: (data['sleepEnd'] as Timestamp?)?.toDate() ?? DateTime.now(),
      wakeTimeTarget: (data['wakeTimeTarget'] as Timestamp?)?.toDate(),
      confirmed: data['confirmed'] as bool?,
      confirmedAt: (data['confirmedAt'] as Timestamp?)?.toDate(),
      bedResistanceMetric: (data['bedResistanceMetric'] as num?)?.toDouble(),
      source: LogSource.values.firstWhere(
        (e) => e.name == sourceStr,
        orElse: () => LogSource.detected,
      ),
      isAnalysisReady: data['isAnalysisReady'] as bool? ?? false,
      analysisNotes: data['analysisNotes'] as String?,
    );
  }
}