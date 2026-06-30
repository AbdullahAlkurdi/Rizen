library rizen_cli;

import 'package:firebase_core/firebase_core.dart';
import 'package:dotenv/dotenv.dart';
import 'dart:io';

export 'auth/auth_service.dart';

Future<void> initialize() async {
  final envFile = File('.env');
  if (envFile.existsSync()) {
    final result = dotenv.load(envFile);
  }
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY'] ?? '',
      appId: dotenv.env['FIREBASE_APP_ID'] ?? '',
      messagingSenderId: dotenv.env['FIREBASE_SENDER_ID'] ?? '',
      projectId: dotenv.env['FIREBASE_PROJECT_ID'] ?? '',
      authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN'] ?? '',
      storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '',
    ),
  );
}
