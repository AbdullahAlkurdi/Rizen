import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/services/voice_parse_result.dart';
import '../../../../core/services/voice_log_orchestrator.dart';

sealed class VoiceState extends Equatable {
  const VoiceState();

  @override
  List<Object?> get props => [];
}

final class VoiceInitial extends VoiceState {}
final class VoicePermissionDenied extends VoiceState {}
final class VoiceListening extends VoiceState {
  final String partialTranscript;
  const VoiceListening(this.partialTranscript);

  @override
  List<Object?> get props => [partialTranscript];
}
final class VoiceProcessing extends VoiceState {
  final String transcript;
  const VoiceProcessing(this.transcript);

  @override
  List<Object?> get props => [transcript];
}
final class VoiceApplying extends VoiceState {
  final VoiceParseResult result;
  const VoiceApplying(this.result);

  @override
  List<Object?> get props => [result];
}
final class VoiceSuccess extends VoiceState {
  final VoiceLogSummary summary;
  final VoiceParseResult result;
  const VoiceSuccess(this.summary, this.result);

  @override
  List<Object?> get props => [summary, result];
}
final class VoiceError extends VoiceState {
  final String message;
  final VoidCallback retry;
  const VoiceError(this.message, this.retry);

  @override
  List<Object?> get props => [message];
}
