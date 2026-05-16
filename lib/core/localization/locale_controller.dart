import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kPrefsLocaleCode = 'driver_app_locale';

class LocaleController extends ChangeNotifier {
  LocaleController(this._prefs);

  final SharedPreferences _prefs;

  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void hydrate() {
    final saved = _prefs.getString(_kPrefsLocaleCode);
    if (saved == 'ar') {
      _locale = const Locale('ar');
    } else if (saved == 'en') {
      _locale = const Locale('en');
    } else {
      _locale = _localeFromPlatform();
    }
    notifyListeners();
  }

  static Locale _localeFromPlatform() {
    final code =
        ui.PlatformDispatcher.instance.locale.languageCode.toLowerCase();
    if (code == 'ar') return const Locale('ar');
    return const Locale('en');
  }

  Future<void> setLocale(Locale locale) async {
    final code = locale.languageCode;
    if (code != 'ar' && code != 'en') return;
    _locale = Locale(code);
    await _prefs.setString(_kPrefsLocaleCode, code);
    notifyListeners();
  }
}
