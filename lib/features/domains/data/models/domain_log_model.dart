import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'domain_log_model.freezed.dart';
part 'domain_log_model.g.dart';

@freezed
class DomainLog with _$DomainLog {
  const factory DomainLog({
    required String id,
    required String domainId,
    required int duration,
    String? notes,
    required DateTime loggedAt,
    String? metricLabel,
    double? metricValue,
  }) = _DomainLog;

  factory DomainLog.fromJson(Map<String, dynamic> json) =>
      _$DomainLogFromJson(json);

  factory DomainLog.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DomainLog.fromJson({
      'id': doc.id,
      'domainId':
          data['domainId'] as String? ?? data['domain'] as String? ?? '',
      'duration':
          data['duration'] as int? ?? data['durationMinutes'] as int? ?? 0,
      'notes': data['notes'] as String? ?? data['note'] as String?,
      'loggedAt':
          (data['loggedAt'] as Timestamp?)?.toDate() ??
          (data['timestamp'] as Timestamp?)?.toDate() ??
          DateTime.now(),
      'metricLabel': data['metricLabel'] as String?,
      'metricValue': (data['metricValue'] as num?)?.toDouble(),
    });
  }
}
