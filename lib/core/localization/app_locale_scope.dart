import 'package:flutter/material.dart';

import 'locale_controller.dart';

class AppLocaleScope extends InheritedNotifier<LocaleController> {
  const AppLocaleScope({
    super.key,
    required super.notifier,
    required super.child,
  });

  static LocaleController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppLocaleScope>();
    assert(scope?.notifier != null, 'AppLocaleScope missing above this context');
    return scope!.notifier!;
  }
}
