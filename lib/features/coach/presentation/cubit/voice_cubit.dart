import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../../core/services/gemini_service.dart';
import 'voice_state.dart';

class CoachVoiceCubit extends Cubit<VoiceState> {
  CoachVoiceCubit({required GeminiService geminiService})
      : _geminiService = geminiService,
        super(VoiceInitial());

  final GeminiService _geminiService;
  final SpeechToText _speech = SpeechToText();
  String _currentTranscript = '';

  Future<bool> initialize() async {
    return await _speech.initialize();
  }

  Future<void> startListening() async {
    _currentTranscript = '';
    final available = await initialize();
    if (!available) {
      emit(VoiceError('Speech recognition not available'));
      return;
    }
    emit(VoiceListening(transcript: ''));
    _speech.listen(
      onResult: (result) {
        _currentTranscript = result.recognizedWords;
        emit(VoiceListening(transcript: _currentTranscript));
      },
      listenOptions: SpeechListenOptions(partialResults: true),
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
    final transcript = _currentTranscript;
    if (transcript.trim().isEmpty) {
      emit(VoiceInitial());
      return;
    }
    emit(VoiceProcessing(transcript));
    try {
      final result = await _parseText(transcript);
      emit(VoiceParsed(result));
    } catch (e) {
      emit(VoiceError(e.toString()));
    }
  }

  Future<CoachVoiceParseResult> _parseText(String text) async {
    final prompt = '''Extract structured data from this voice note:
$text

Return JSON with:
- domain: one of [sports, study, work, coding, nutrition, spiritual, custom] or null
- duration: number or null
- notes: string
- todo_items: array of strings
- habit_name: string or null
- confidence_score: number 0-1

If unclear, set confidence_score low.''';

    try {
      final response = await _geminiService.generateContent(prompt);
      final cleaned = response.replaceAll('```json', '').replaceAll('```', '').trim();
      final json = jsonDecode(cleaned) as Map<String, dynamic>;

      VoiceDomain? domain;
      final domainStr = json['domain'] as String?;
      if (domainStr != null) {
        domain = VoiceDomain.values.firstWhere(
          (e) => e.name == domainStr.toLowerCase(),
          orElse: () => VoiceDomain.custom,
        );
      }

      return CoachVoiceParseResult(
        domain: domain,
        duration: json['duration'] as int?,
        notes: json['notes'] as String?,
        todoItems: (json['todo_items'] as List<dynamic>?)?.cast<String>(),
        habitName: json['habit_name'] as String?,
        confidenceScore: (json['confidence_score'] as num?)?.toDouble() ?? 0.5,
        rawTranscript: text,
      );
    } catch (e) {
      return CoachVoiceParseResult(
        confidenceScore: 0.0,
        rawTranscript: text,
        notes: 'Failed to parse: $e',
      );
    }
  }

  Future<void> processText(String text) async {
    if (text.trim().isEmpty) {
      emit(VoiceError('Text is empty'));
      return;
    }
    emit(VoiceProcessing(text));
    try {
      final result = await _parseText(text);
      emit(VoiceParsed(result));
    } catch (e) {
      emit(VoiceError(e.toString()));
    }
  }

  Future<void> logResult(CoachVoiceParseResult result) async {
    emit(VoiceLogging(result));
    emit(VoiceLogged('Voice log saved'));
  }

  Future<void> getHistory() async {
    emit(VoiceHistoryLoading());
    emit(const VoiceHistoryLoaded([]));
  }

  void reset() => emit(VoiceInitial());
}