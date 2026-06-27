// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coach_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CoachMessageImpl _$$CoachMessageImplFromJson(Map<String, dynamic> json) =>
    _$CoachMessageImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      content: json['content'] as String,
      role: $enumDecode(_$CoachRoleEnumMap, json['role']),
      timestamp: _dateTimeFromJson(json['timestamp']),
      sessionId: json['sessionId'] as String,
    );

Map<String, dynamic> _$$CoachMessageImplToJson(_$CoachMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'content': instance.content,
      'role': _$CoachRoleEnumMap[instance.role]!,
      'timestamp': _dateTimeToJson(instance.timestamp),
      'sessionId': instance.sessionId,
    };

const _$CoachRoleEnumMap = {
  CoachRole.user: 'user',
  CoachRole.assistant: 'assistant',
};
