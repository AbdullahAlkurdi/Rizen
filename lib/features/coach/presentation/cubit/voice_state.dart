import 'package:equatable/equatable.dart';

enum VoiceDomain { sports, study, work, coding, nutrition, spiritual, custom }

class CoachVoiceParseResult {
  CoachVoiceParseResult({
    this.domain,
    this.duration,
    this.notes,
    this.todoItems,
    this.habitName,
    required this.confidenceScore,
    required this.rawTranscript,
  });

  final VoiceDomain? domain;
  final int? duration;
  final String? notes;
  final List<String>? todoItems;
  final String? habitName;
  final double confidenceScore;
  final String rawTranscript;
}

sealed class VoiceState extends Equatable {
  const VoiceState();

  @override
  List<Object?> get props => [];
}

final class VoiceInitial extends VoiceState {}

final class VoiceListening extends VoiceState {
  const VoiceListening({required this.transcript});

  final String transcript;

  @override
  List<Object?> get props => [transcript];
}

final class VoiceProcessing extends VoiceState {
  const VoiceProcessing(this.transcript);

  final String transcript;

  @override
  List<Object?> get props => [transcript];
}

final class VoiceParsed extends VoiceState {
  const VoiceParsed(this.result);

  final CoachVoiceParseResult result;

  @override
  List<Object?> get props => [result];
}

final class VoiceLogging extends VoiceState {
  const VoiceLogging(this.result);

  final CoachVoiceParseResult result;

  @override
  List<Object?> get props => [result];
}

final class VoiceLogged extends VoiceState {
  const VoiceLogged(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class VoiceError extends VoiceState {
  const VoiceError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class VoiceHistoryLoading extends VoiceState {}

final class VoiceHistoryLoaded extends VoiceState {
  const VoiceHistoryLoaded(this.logs);

  final List<VoiceHistoryEntry> logs;

  @override
  List<Object?> get props => [logs];
}

class VoiceHistoryEntry {
  VoiceHistoryEntry({
    required this.id,
    required this.date,
    required this.domain,
    required this.duration,
    required this.notesExcerpt,
  });

  final String id;
  final DateTime date;
  final String? domain;
  final int? duration;
  final String notesExcerpt;
}