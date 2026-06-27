import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rizen/core/localization/locale_cubit.dart';
import 'package:rizen/firebase_options.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final localeCubit = LocaleCubit();
  await localeCubit.init();

  runApp(
    BlocProvider<LocaleCubit>.value(
      value: localeCubit,
      child: const RizenApp(),
    ),
  );
}
