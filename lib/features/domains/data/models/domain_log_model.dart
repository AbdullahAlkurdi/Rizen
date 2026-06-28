import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'domain_log_model.freezed.dart';
part 'domain_log_model.g.dart';

@freezed
class DomainLog with _$DomainLog {
  const factory DomainLog({
    required String id,
    required String uid,
    required String domainId,
    required int duration,
    @Default(5) int intensity,
    String? notes,
    required DateTime loggedAt,
    String? metricLabel,
    double? metricValue,
    @Default(false) bool hasTodoList,
    @Default(70) int completionThreshold,
    @Default(100.0) double completionPct,
  }) = _DomainLog;

  factory DomainLog.fromJson(Map<String, dynamic> json) =>
      _$DomainLogFromJson(json);

  factory DomainLog.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DomainLog(
      id: doc.id,
      uid: data['uid'] as String? ?? '',
      domainId: data['domainId'] as String? ?? data['domain'] as String? ?? '',
      duration: data['duration'] as int? ?? data['durationMinutes'] as int? ?? 0,
      intensity: data['intensity'] as int? ?? 5,
      notes: data['notes'] as String? ?? data['note'] as String?,
      loggedAt:
          (data['loggedAt'] as Timestamp?)?.toDate() ??
          (data['timestamp'] as Timestamp?)?.toDate() ??
          DateTime.now(),
      metricLabel: data['metricLabel'] as String?,
      metricValue: (data['metricValue'] as num?)?.toDouble(),
      hasTodoList: data['hasTodoList'] as bool? ?? false,
      completionThreshold: data['completionThreshold'] as int? ?? 70,
      completionPct: (data['completionPct'] as num?)?.toDouble() ?? 100.0,
    );
  }
}
