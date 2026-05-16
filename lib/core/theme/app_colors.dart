import 'package:flutter/material.dart';

/// Design tokens from delivery Figma (`#A3090F` primary, Material 3 surfaces).
class AppColors {
  AppColors._();

  static const primary = Color(0xFFA3090F);
  static const text = Color(0xFFFFFFFF);
  static const secondary = Color(0xFF2EC4B6);
  static const error = Color(0xFFEC2D30);
  static const success = Color(0xFF0C9D61);
  static const warning = Color(0xFFF1D060);
  static const _neutralDarkStroke = Color(0xFF1A1A1A);
  static const flagRed = Color(0xFFCE1126);
  static const transparent = Color(0x00000000);

  static const online = Color(0xFF43A047);
  static const offline = Color(0xFF9E9E9E);

  static Color onSurface(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  static Color paragraph(BuildContext context) =>
      Theme.of(context).colorScheme.onSurfaceVariant;

  static Color scaffoldBackground(BuildContext context) =>
      Theme.of(context).scaffoldBackgroundColor;

  static Color surfaceCard(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  static Color border(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? _neutralDarkStroke
          : Theme.of(context).colorScheme.outline;

  static Color hint(BuildContext context) => Theme.of(context).hintColor;

  static Color fieldError(BuildContext context) =>
      Theme.of(context).colorScheme.error;

  static Color fieldFocusBorder(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? text
          : onSurface(context);

  static Color otpActiveBorder(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? text
          : const Color(0xFF141414);

  static Color cursor(BuildContext context) => onSurface(context);

  static Color modalBarrierScrim(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45);

  static Color languageModalBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF080404)
        : const Color(0xFFFAFAFA);
  }

  static Color languageModalBorder(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return _neutralDarkStroke;
    }
    return Theme.of(context).colorScheme.outline;
  }

  static Color languageModalDivider(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return _neutralDarkStroke;
    }
    return Theme.of(context).colorScheme.outline;
  }

  static Color languageModalBarrier(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? const Color(0x80000000)
        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45);
  }

  static Color uploadDashedBorder(BuildContext context) => primary;

  static Color documentUploadStroke(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? text
          : const Color(0xFFB6B6B6);

  static Color profilePhotoOverlay(BuildContext context) =>
      const Color(0x33130000);
}
