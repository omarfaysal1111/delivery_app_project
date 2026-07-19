import 'package:flutter/material.dart';
import 'package:delivery_app_project/core/theme/theme_controller.dart';

class AppThemeScope extends InheritedNotifier<ThemeController> {
  const AppThemeScope({
    super.key,
    required super.notifier,
    required super.child,
  });

  static ThemeController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppThemeScope>();
    assert(scope?.notifier != null, 'AppThemeScope missing above this context');
    return scope!.notifier!;
  }
}
