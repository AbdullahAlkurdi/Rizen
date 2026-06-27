import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coach_message_model.freezed.dart';
part 'coach_message_model.g.dart';

// ignore_for_file: invalid_annotation_target

enum CoachRole { user, assistant }

DateTime _dateTimeFromJson(Object? value) {
  if (value is Timestamp) return value.toDate();
  if (value is DateTime) return value;
  if (value is String) return DateTime.parse(value);
  return DateTime.now();
}

String _dateTimeToJson(DateTime value) => value.toIso8601String();

@freezed
class CoachMessage with _$CoachMessage {
  const CoachMessage._();

  const factory CoachMessage({
    required String id,
    required String uid,
    required String content,
    required CoachRole role,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required DateTime timestamp,
    required String sessionId,
  }) = _CoachMessage;

  factory CoachMessage.fromJson(Map<String, dynamic> json) =>
      _$CoachMessageFromJson(json);

  factory CoachMessage.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CoachMessage.fromJson({
      'id': doc.id,
      'uid': data['uid'] as String? ?? '',
      'content': data['content'] as String? ?? '',
      'role': data['role'] as String? ?? CoachRole.user.name,
      'timestamp': data['timestamp'],
      'sessionId': data['sessionId'] as String? ?? '',
    });
  }

  Map<String, dynamic> toFirestore() => {
        'uid': uid,
        'content': content,
        'role': role.name,
        'timestamp': Timestamp.fromDate(timestamp),
        'sessionId': sessionId,
      };
}
