import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/constants/app_config.dart';
import '../models/transaction_model.dart';

abstract class FinanceQuickEntryParser {
  Future<ParsedFinanceEntry> parse(String input);
}

class ParsedFinanceEntry {
  const ParsedFinanceEntry({
    required this.amount,
    required this.description,
    this.category,
    this.type = TransactionType.expense,
    required this.sanitizedInput,
  });

  final double amount;
  final String description;
  final String? category;
  final TransactionType type;
  final String sanitizedInput;
}

class GeminiFinanceQuickEntryParser implements FinanceQuickEntryParser {
  GeminiFinanceQuickEntryParser({Dio? dio, String? apiKey})
    : _dio = dio ?? Dio(),
      _apiKey = apiKey;

  final Dio _dio;
  final String? _apiKey;

  @override
  Future<ParsedFinanceEntry> parse(String input) async {
    final sanitized = FinancePiiStripper.strip(input);
    if (sanitized.trim().isEmpty) {
      throw const FormatException('Enter an expense to parse');
    }

    final key = _apiKey ?? AppConfig.geminiApiKey;
    if (key.trim().isEmpty) {
      throw TimeoutException('Gemini API key is not configured');
    }

    final response = await _dio
        .post<Map<String, dynamic>>(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent',
          queryParameters: {'key': key},
          data: {
            'contents': [
              {
                'parts': [
                  {
                    'text':
                        'Parse this personal finance entry into strict JSON only. '
                        'Schema: {"amount": number, "description": string, '
                        '"category": string|null, "type": "income"|"expense"}. '
                        'Default type is expense. Do not include markdown. '
                        'Entry: "$sanitized"',
                  },
                ],
              },
            ],
            'generationConfig': {
              'responseMimeType': 'application/json',
              'temperature': 0,
            },
          },
          options: Options(
            sendTimeout: const Duration(seconds: 2),
            receiveTimeout: const Duration(seconds: 2),
          ),
        )
        .timeout(const Duration(seconds: 2));

    final text = _extractText(response.data);
    final json = jsonDecode(text) as Map<String, dynamic>;
    final amount = (json['amount'] as num?)?.toDouble();
    final description = json['description'] as String?;
    if (amount == null || amount <= 0 || description == null) {
      throw const FormatException('Gemini returned an incomplete transaction');
    }

    return ParsedFinanceEntry(
      amount: amount,
      description: description.trim().isEmpty ? sanitized : description.trim(),
      category: (json['category'] as String?)?.trim(),
      type: json['type'] == TransactionType.income.name
          ? TransactionType.income
          : TransactionType.expense,
      sanitizedInput: sanitized,
    );
  }

  String _extractText(Map<String, dynamic>? data) {
    final candidates = data?['candidates'] as List<dynamic>?;
    final first = candidates?.firstOrNull as Map<String, dynamic>?;
    final content = first?['content'] as Map<String, dynamic>?;
    final parts = content?['parts'] as List<dynamic>?;
    final part = parts?.firstOrNull as Map<String, dynamic>?;
    final text = part?['text'] as String?;
    if (text == null || text.trim().isEmpty) {
      throw const FormatException('Gemini returned no parseable text');
    }
    return text;
  }
}

class FinancePiiStripper {
  FinancePiiStripper._();

  static String strip(String input) {
    return input
        .replaceAll(
          RegExp(
            r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b',
            caseSensitive: false,
          ),
          '[email]',
        )
        .replaceAll(RegExp(r'\+?\d[\d\s().-]{7,}\d'), '[phone]')
        .replaceAll(RegExp(r'\b(?:\d[ -]*?){13,19}\b'), '[card]')
        .replaceAll(RegExp(r'\b[A-Z]{2}\d{2}[A-Z0-9]{11,30}\b'), '[iban]')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}
