import 'package:dio/dio.dart';
import '../config/app_config.dart';

class GeminiService {
  final Dio _dio;

  GeminiService({Dio? dio}) : _dio = dio ?? Dio();

  Future<String> generateContent(String prompt) async {
    final apiKey = AppConfig.geminiApiKey;
    if (apiKey.trim().isEmpty) {
      throw Exception('Gemini API key is not configured');
    }

    final response = await _dio
        .post(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent',
          queryParameters: {'key': apiKey},
          data: {
            'contents': [
              {'parts': [{'text': prompt}]}
            ],
            'generationConfig': {
              'responseMimeType': 'text/plain',
              'temperature': 0.7,
            },
          },
          options: Options(
            sendTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        )
        .timeout(const Duration(seconds: 10));

    final candidates = response.data?['candidates'] as List<dynamic>?;
    if (candidates == null || candidates.isEmpty) {
      throw Exception('Gemini returned no candidates');
    }

    final content = (candidates.first as Map<String, dynamic>)['content']
        as Map<String, dynamic>?;
    final parts = content?['parts'] as List<dynamic>?;
    if (parts == null || parts.isEmpty) {
      throw Exception('Gemini returned no parts');
    }

    final text = (parts.first as Map<String, dynamic>)['text'] as String?;
    if (text == null || text.trim().isEmpty) {
      throw Exception('Gemini returned empty text');
    }

    return text.trim();
  }
}
