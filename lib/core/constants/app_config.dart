import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  AppConfig._();

  static String get geminiApiKey =>
      dotenv.get('GEMINI_API_KEY');
}
