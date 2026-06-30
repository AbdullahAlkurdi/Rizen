import 'dart:convert';

import 'package:dio/dio.dart';
import 'voice_parse_result.dart';

class VoiceParserService {
  final String _geminiApiKey;
  final Dio _dio;

  VoiceParserService({
    required String geminiApiKey,
    required Dio dio,
  }) : _geminiApiKey = geminiApiKey,
       _dio = dio;

  static const _systemPrompt = '''
You are a life data extraction assistant
for a productivity app called Rizen.

The user has just spoken a voice note
describing their day or activities.

Extract the following entities and return
ONLY a valid JSON object. No markdown.
No explanation. No preamble.

JSON schema:
{
  "domain_logs": [
    {
      "domain": string,
      "duration_minutes": int | null,
      "notes": string | null
    }
  ],
  "habits_completed": [string],
  "habits_missed": [string],
  "todo_checked": [string],
  "todo_unchecked": [string],
  "reflection": string | null,
  "sleep_note": string | null
}

Rules:
- Use fuzzy matching for domain names
- If duration not mentioned set null
- If nothing found for a field use []
  or null
- Never invent data not in the transcript
- Dates always refer to today
''';

  Future<VoiceParseResult> parse(String transcript) async {
    if (_geminiApiKey.trim().isEmpty) {
      return VoiceParseResult(
        domainLogs: [],
        habitsCompleted: [],
        habitsMissed: [],
        todoChecked: [],
        todoUnchecked: [],
        reflection: null,
        sleepNote: null,
        rawTranscript: transcript,
        parseSuccess: false,
        parseError: 'Gemini API key is not configured',
      );
    }

    try {
      final response = await _dio
          .post(
            'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent',
            options: Options(
              headers: {
                'x-goog-api-key': _geminiApiKey,
                'Content-Type': 'application/json',
              },
              sendTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 15),
            ),
            data: {
              'contents': [
                {
                  'parts': [
                    {
                      'text':
                          '$_systemPrompt\n\nUser transcript: $transcript',
                    },
                  ],
                },
              ],
            },
          )
          .timeout(const Duration(seconds: 15));

      final candidates =
          response.data?['candidates'] as List<dynamic>?;
      if (candidates == null || candidates.isEmpty) {
        throw Exception('Gemini returned no candidates');
      }

      final content =
          (candidates.first as Map<String, dynamic>)['content']
              as Map<String, dynamic>?;
      final parts = content?['parts'] as List<dynamic>?;
      if (parts == null || parts.isEmpty) {
        throw Exception('Gemini returned no parts');
      }

      final text = (parts.first as Map<String, dynamic>)['text'] as String?;
      if (text == null || text.trim().isEmpty) {
        throw Exception('Gemini returned empty text');
      }

      String cleaned = text.trim();
      if (cleaned.startsWith('```')) {
        cleaned = cleaned.replaceFirst(RegExp(r'^```\w*\n?'), '');
        cleaned = cleaned.replaceFirst(RegExp(r'\n?```$'), '');
      }

      final json = jsonDecode(cleaned) as Map<String, dynamic>;

      return VoiceParseResult.fromJson({
        ...json,
        'rawTranscript': transcript,
        'parseSuccess': true,
      });
    } catch (e) {
      return VoiceParseResult(
        domainLogs: [],
        habitsCompleted: [],
        habitsMissed: [],
        todoChecked: [],
        todoUnchecked: [],
        reflection: null,
        sleepNote: null,
        rawTranscript: transcript,
        parseSuccess: false,
        parseError: e.toString(),
      );
    }
  }
}
