import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

final class ThemeLoaded extends ThemeState {
  ThemeLoaded(this.mode);
  final ThemeMode mode;
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  Future<void> loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('theme_preference') ?? 'system';
    final mode = switch (themeString) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    emit(ThemeLoaded(mode));
  }

  Future<void> setLight() async {
    await _saveAndEmit(ThemeMode.light);
  }

  Future<void> setDark() async {
    await _saveAndEmit(ThemeMode.dark);
  }

  Future<void> setSystem() async {
    await _saveAndEmit(ThemeMode.system);
  }

  Future<void> _saveAndEmit(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await prefs.setString('theme_preference', themeString);
    emit(ThemeLoaded(mode));
  }
}