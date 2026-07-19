import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:delivery_app_project/core/theme/app_colors.dart';
import 'package:delivery_app_project/core/theme/text_styles.dart';
import 'package:delivery_app_project/l10n/app_localizations.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bg = AppColors.scaffoldBackground(context);
    final fg = AppColors.onSurface(context);
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        foregroundColor: fg,
        elevation: 0,
        leading: BackButton(color: fg, onPressed: () => context.pop()),
        title: Text(l10n.termsTitle, style: AppTextStyles.appBarTitle(context)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 20, 32),
        child: Text(
          l10n.termsBody,
          textAlign: TextAlign.start,
          style: AppTextStyles.termsBody(context),
        ),
      ),
    );
  }
}
