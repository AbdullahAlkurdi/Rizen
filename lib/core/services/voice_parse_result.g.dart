// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_parse_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoiceParseResultImpl _$$VoiceParseResultImplFromJson(
  Map<String, dynamic> json,
) => _$VoiceParseResultImpl(
  domainLogs: (json['domainLogs'] as List<dynamic>)
      .map((e) => DomainLogEntry.fromJson(e as Map<String, dynamic>))
      .toList(),
  habitsCompleted: (json['habitsCompleted'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  habitsMissed: (json['habitsMissed'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  todoChecked: (json['todoChecked'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  todoUnchecked: (json['todoUnchecked'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  reflection: json['reflection'] as String?,
  sleepNote: json['sleepNote'] as String?,
  rawTranscript: json['rawTranscript'] as String,
  parseSuccess: json['parseSuccess'] as bool,
  parseError: json['parseError'] as String?,
);

Map<String, dynamic> _$$VoiceParseResultImplToJson(
  _$VoiceParseResultImpl instance,
) => <String, dynamic>{
  'domainLogs': instance.domainLogs,
  'habitsCompleted': instance.habitsCompleted,
  'habitsMissed': instance.habitsMissed,
  'todoChecked': instance.todoChecked,
  'todoUnchecked': instance.todoUnchecked,
  'reflection': instance.reflection,
  'sleepNote': instance.sleepNote,
  'rawTranscript': instance.rawTranscript,
  'parseSuccess': instance.parseSuccess,
  'parseError': instance.parseError,
};

_$DomainLogEntryImpl _$$DomainLogEntryImplFromJson(Map<String, dynamic> json) =>
    _$DomainLogEntryImpl(
      domain: json['domain'] as String,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$DomainLogEntryImplToJson(
  _$DomainLogEntryImpl instance,
) => <String, dynamic>{
  'domain': instance.domain,
  'durationMinutes': instance.durationMinutes,
  'notes': instance.notes,
};
