import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kPrefsThemeMode = 'app_theme_mode';

class ThemeController extends ChangeNotifier {
  ThemeController(this._prefs);

  final SharedPreferences _prefs;

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void hydrate() {
    _themeMode = switch (_prefs.getString(_kPrefsThemeMode)) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    if (_themeMode == themeMode) {
      return;
    }

    _themeMode = themeMode;
    await _prefs.setString(_kPrefsThemeMode, themeMode.name);
    notifyListeners();
  }
}
