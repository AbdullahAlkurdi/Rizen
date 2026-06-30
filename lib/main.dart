import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rizen/core/injection_container.dart';
import 'package:rizen/core/localization/locale_cubit.dart';
import 'package:rizen/core/theme/app_theme.dart';
import 'package:rizen/core/theme/theme_cubit.dart';
import 'package:rizen/core/router/app_router.dart';
import 'package:rizen/firebase_options.dart';
import 'package:rizen/generated/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rizen/core/services/app_lifecycle_observer.dart';

/// Main entry point for RizenOS.
///
/// AppLifecycleObserver is attached here to capture the first app resume after midnight
/// as a wake-up event for sleep tracking. This is the v1 implementation using the
/// app lifecycle as a proxy for OS-level unlock detection.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();

  final localeCubit = LocaleCubit();
  await localeCubit.init();

  runApp(
    BlocProvider<LocaleCubit>.value(
      value: localeCubit,
      child: const RizenApp(),
    ),
  );
}

/// Root widget that sets up the app lifecycle observer.
/// The observer is the only stateful component outside lib/features/home/.
class RizenApp extends StatefulWidget {
  const RizenApp({super.key});

  @override
  State<RizenApp> createState() => _RizenAppState();
}

class _RizenAppState extends State<RizenApp> {
  late final AppLifecycleObserver _observer;

  @override
  void initState() {
    super.initState();
    _observer = AppLifecycleObserver(
      sleepTrackingService: sl(),
    );
    WidgetsBinding.instance.addObserver(_observer);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_observer);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const RizenAppView();
  }
}

class RizenAppView extends StatelessWidget {
  const RizenAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final isArabic = locale.languageCode == 'ar';
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            final themeMode = themeState is ThemeLoaded ? themeState.mode : ThemeMode.system;
            return MaterialApp.router(
              title: 'RizenOS',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light(isArabic: isArabic),
              darkTheme: AppTheme.dark(isArabic: isArabic),
              themeMode: themeMode,
              routerConfig: appRouter,
              locale: locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (Locale? cl, Iterable<Locale> su) {
                for (final s in su) {
                  if (s.languageCode == cl?.languageCode) return s;
                }
                return const Locale('en');
              },
            );
          },
        );
      },
    );
  }
}