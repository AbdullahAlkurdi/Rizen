import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:dotenv/dotenv.dart' as dotenv;

export 'auth/auth_service.dart';

final dotenv.DotEnv env = dotenv.DotEnv(includePlatformEnvironment: true);

Future<void> initialize() async {
  final envFile = File('.env');
  if (envFile.existsSync()) {
    env.load(['.env']);
  }
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: env['FIREBASE_API_KEY'] ?? '',
      appId: env['FIREBASE_APP_ID'] ?? '',
      messagingSenderId: env['FIREBASE_SENDER_ID'] ?? '',
      projectId: env['FIREBASE_PROJECT_ID'] ?? '',
      authDomain: env['FIREBASE_AUTH_DOMAIN'] ?? '',
      storageBucket: env['FIREBASE_STORAGE_BUCKET'] ?? '',
    ),
  );
}
