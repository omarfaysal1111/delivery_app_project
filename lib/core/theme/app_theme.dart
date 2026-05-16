import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const _fontFamilyArabic = 'ExpoArabic';

  static final ThemeData lightArabic =
      _buildLight(fontFamily: _fontFamilyArabic);
  static final ThemeData lightEnglish = _buildLight(fontFamily: null);
  static final ThemeData darkArabic = _buildDark(fontFamily: _fontFamilyArabic);
  static final ThemeData darkEnglish = _buildDark(fontFamily: null);

  static ThemeData themeFor(Locale locale, Brightness brightness) {
    final arabic = locale.languageCode == 'ar';
    if (brightness == Brightness.dark) {
      return arabic ? darkArabic : darkEnglish;
    }
    return arabic ? lightArabic : lightEnglish;
  }

  static ThemeData _buildLight({String? fontFamily}) => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: fontFamily,
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        hintColor: const Color(0xFFB9B9B9),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: AppColors.text,
          secondary: AppColors.secondary,
          onSecondary: Color(0xFF1B1B1B),
          error: AppColors.error,
          onError: AppColors.text,
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFF1B1B1B),
          onSurfaceVariant: Color(0xFFA7A7A7),
          outline: Color(0xFFE5E5E5),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: const Color(0xFFFFFFFF),
          contentTextStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF1B1B1B),
          ),
          behavior: SnackBarBehavior.floating,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF1B1B1B),
        ),
      );

  static ThemeData _buildDark({String? fontFamily}) => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: fontFamily,
        scaffoldBackgroundColor: const Color(0xFF080404),
        hintColor: const Color(0xFF515151),
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.primary,
          onPrimary: AppColors.text,
          secondary: AppColors.secondary,
          onSecondary: Color(0xFF080404),
          error: AppColors.error,
          onError: AppColors.text,
          surface: Color(0xFF0F0F0F),
          onSurface: Color(0xFFFFFFFF),
          onSurfaceVariant: Color(0xFF999999),
          outline: Color(0xFF1A1A1A),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: const Color(0xFF1A1A1A),
          contentTextStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFFFFFFF),
          ),
          behavior: SnackBarBehavior.floating,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFFFFFFF),
        ),
      );
}
