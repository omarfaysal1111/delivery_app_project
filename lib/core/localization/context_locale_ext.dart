import 'package:flutter/material.dart';

extension LocaleContextX on BuildContext {
  bool get isArabic =>
      Localizations.localeOf(this).languageCode.toLowerCase() == 'ar';
}
