import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../core/services/voice_parser_service.dart';
import '../../../../core/services/voice_log_orchestrator.dart';
import 'voice_state.dart';

class VoiceCubit extends Cubit<VoiceState> {
  VoiceCubit({
    required VoiceParserService parserService,
    required VoiceLogOrchestrator orchestrator,
  }) : _parserService = parserService,
       _orchestrator = orchestrator,
       super(VoiceInitial());

  final VoiceParserService _parserService;
  final VoiceLogOrchestrator _orchestrator;
  final SpeechToText _speechToText = SpeechToText();
  String _lastTranscript = '';

  Future<void> requestPermissionAndStart() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      emit(VoicePermissionDenied());
      return;
    }

    final available = await _speechToText.initialize();
    if (available) {
      _lastTranscript = '';
      emit(VoiceListening(''));
      _speechToText.listen(
        onResult: (result) {
          _lastTranscript = result.recognizedWords;
          emit(VoiceListening(_lastTranscript));
          if (result.finalResult) {
            _processTranscript(_lastTranscript);
          }
        },
        listenOptions: SpeechListenOptions(partialResults: true),
      );
    } else {
      emit(VoiceError('Speech recognition not available', retry));
    }
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
    _processTranscript(_lastTranscript);
  }

  Future<void> _processTranscript(String transcript) async {
    if (transcript.trim().isEmpty) {
      emit(VoiceInitial());
      return;
    }

    emit(VoiceProcessing(transcript));
    try {
      final parseResult = await _parserService.parse(transcript);
      emit(VoiceApplying(parseResult));
      final summary = await _orchestrator.apply(parseResult);
      emit(VoiceSuccess(summary, parseResult));
    } catch (e) {
      emit(VoiceError(e.toString(), retry));
    }
  }

  void retry() {
    emit(VoiceInitial());
  }

  @override
  Future<void> close() {
    _speechToText.cancel();
    return super.close();
  }
}
