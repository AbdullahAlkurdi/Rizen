import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/localization/locale_cubit.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'generated/app_localizations.dart';

class RizenApp extends StatelessWidget {
  const RizenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit()..loadSavedTheme(),
      child: BlocBuilder<LocaleCubit, Locale>(
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
      ),
    );
  }
}
