import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_parse_result.freezed.dart';
part 'voice_parse_result.g.dart';

@freezed
class VoiceParseResult with _$VoiceParseResult {
  const factory VoiceParseResult({
    required List<DomainLogEntry> domainLogs,
    required List<String> habitsCompleted,
    required List<String> habitsMissed,
    required List<String> todoChecked,
    required List<String> todoUnchecked,
    required String? reflection,
    required String? sleepNote,
    required String rawTranscript,
    required bool parseSuccess,
    String? parseError,
  }) = _VoiceParseResult;

  factory VoiceParseResult.fromJson(Map<String, dynamic> json) =>
      _$VoiceParseResultFromJson(json);
}

@freezed
class DomainLogEntry with _$DomainLogEntry {
  const factory DomainLogEntry({
    required String domain,
    int? durationMinutes,
    String? notes,
  }) = _DomainLogEntry;

  factory DomainLogEntry.fromJson(Map<String, dynamic> json) =>
      _$DomainLogEntryFromJson(json);
}
