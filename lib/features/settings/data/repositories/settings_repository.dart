import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  SettingsRepository({SharedPreferences? prefs}) : _prefs = prefs;

  SharedPreferences? _prefs;

  Future<void> _ensurePrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static const _themeKey = 'theme';
  static const _languageKey = 'language';
  static const _notificationsKey = 'notifications_enabled';
  static const _currencyKey = 'currency';

  Future<String?> getTheme() async {
    await _ensurePrefs();
    return _prefs!.getString(_themeKey);
  }

  Future<void> setTheme(String theme) async {
    await _ensurePrefs();
    await _prefs!.setString(_themeKey, theme);
  }

  Future<String?> getLanguage() async {
    await _ensurePrefs();
    return _prefs!.getString(_languageKey);
  }

  Future<void> setLanguage(String lang) async {
    await _ensurePrefs();
    await _prefs!.setString(_languageKey, lang);
  }

  Future<bool> getNotificationsEnabled() async {
    await _ensurePrefs();
    return _prefs!.getBool(_notificationsKey) ?? true;
  }

  Future<void> setNotificationsEnabled(bool val) async {
    await _ensurePrefs();
    await _prefs!.setBool(_notificationsKey, val);
  }

  Future<String?> getCurrency() async {
    await _ensurePrefs();
    return _prefs!.getString(_currencyKey);
  }

  Future<void> setCurrency(String currency) async {
    await _ensurePrefs();
    await _prefs!.setString(_currencyKey, currency);
  }
}
