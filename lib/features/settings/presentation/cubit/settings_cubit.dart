import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/settings_repository.dart';

sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoaded extends SettingsState {
  SettingsLoaded({
    this.theme = 'system',
    this.language = 'en',
    this.notificationsEnabled = true,
    this.currency = 'USD',
  });

  final String theme;
  final String language;
  final bool notificationsEnabled;
  final String currency;

  SettingsLoaded copyWith({
    String? theme,
    String? language,
    bool? notificationsEnabled,
    String? currency,
  }) {
    return SettingsLoaded(
      theme: theme ?? this.theme,
      language: language ?? this.language,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      currency: currency ?? this.currency,
    );
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({SettingsRepository? repository})
    : _repository = repository ?? SettingsRepository(),
      super(SettingsInitial()) {
    loadSettings();
  }

  final SettingsRepository _repository;

  Future<void> loadSettings() async {
    final theme = await _repository.getTheme();
    final language = await _repository.getLanguage();
    final notifications = await _repository.getNotificationsEnabled();
    final currency = await _repository.getCurrency();

    emit(
      SettingsLoaded(
        theme: theme ?? 'system',
        language: language ?? 'en',
        notificationsEnabled: notifications,
        currency: currency ?? 'USD',
      ),
    );
  }

  Future<void> setTheme(String theme) async {
    await _repository.setTheme(theme);
    if (state is SettingsLoaded) {
      emit((state as SettingsLoaded).copyWith(theme: theme));
    }
  }

  Future<void> setLanguage(String lang) async {
    await _repository.setLanguage(lang);
    if (state is SettingsLoaded) {
      emit((state as SettingsLoaded).copyWith(language: lang));
    }
  }

  Future<void> setNotificationsEnabled(bool val) async {
    await _repository.setNotificationsEnabled(val);
    if (state is SettingsLoaded) {
      emit((state as SettingsLoaded).copyWith(notificationsEnabled: val));
    }
  }

  Future<void> setCurrency(String currency) async {
    await _repository.setCurrency(currency);
    if (state is SettingsLoaded) {
      emit((state as SettingsLoaded).copyWith(currency: currency));
    }
  }
}
