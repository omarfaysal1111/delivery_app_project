import 'package:flutter/material.dart';

import '../../../../core/localization/context_locale_ext.dart';
import 'auth_language_chip.dart';

/// Language chip: top-left in Arabic, top-right in English.
class AuthLanguageChipAlign extends StatelessWidget {
  const AuthLanguageChipAlign({
    super.key,
    required this.label,
    required this.flagAsset,
    required this.onTap,
  });

  final String label;
  final String flagAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final alignment =
        context.isArabic ? Alignment.topLeft : Alignment.topRight;

    return Align(
      alignment: alignment,
      child: AuthLanguageChip(
        flagAsset: flagAsset,
        label: label,
        onTap: onTap,
      ),
    );
  }
}
