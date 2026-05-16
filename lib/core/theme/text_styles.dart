import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle screenTitle(BuildContext context) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface(context),
        height: 1.4,
      );

  static TextStyle subtitle(BuildContext context) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.paragraph(context),
        height: 1.3,
      );

  static TextStyle fieldLabel(BuildContext context) => TextStyle(
        fontSize: 14,
        color: AppColors.onSurface(context),
        height: 1.35,
      );

  static TextStyle inputHint(BuildContext context) => TextStyle(
        fontSize: 12,
        color: AppColors.hint(context),
        height: 1.3,
      );

  static TextStyle inputText(BuildContext context) => TextStyle(
        fontSize: 14,
        color: AppColors.onSurface(context),
        fontWeight: FontWeight.w400,
      );

  static const primaryButtonLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
    height: 1.25,
  );

  static TextStyle languageChipLabel(BuildContext context) => TextStyle(
        fontSize: 12,
        color: AppColors.onSurface(context),
        height: 1.3,
      );

  static TextStyle heading4(BuildContext context) => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface(context),
        height: 1.4,
      );

  static TextStyle body(BuildContext context) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface(context),
        height: 1.25,
      );

  static TextStyle bodyBook(BuildContext context) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.paragraph(context),
        height: 1.35,
      );

  static TextStyle resendAction(BuildContext context) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
        height: 1.25,
      );

  static TextStyle resendActionDisabled(BuildContext context) => TextStyle(
        fontSize: 14,
        color: AppColors.paragraph(context),
        fontWeight: FontWeight.w600,
        height: 1.25,
      );

  static TextStyle timerText(BuildContext context) => TextStyle(
        fontSize: 14,
        color: AppColors.paragraph(context),
        height: 1.35,
      );

  static TextStyle otpDigitActive(BuildContext context) => TextStyle(
        fontSize: 12,
        color: AppColors.onSurface(context),
        height: 1.3,
      );

  static TextStyle otpDigitInactive(BuildContext context) => TextStyle(
        fontSize: 12,
        color: AppColors.paragraph(context),
        height: 1.3,
      );

  static const hiddenOtpInput = TextStyle(
    fontSize: 1,
    height: 1,
    color: AppColors.transparent,
  );

  static TextStyle snackBarMessage(BuildContext context) {
    final base = Theme.of(context).snackBarTheme.contentTextStyle;
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: base?.color ?? AppColors.onSurface(context),
    );
  }

  static TextStyle footerSecondary(BuildContext context) => TextStyle(
        fontSize: 14,
        color: AppColors.paragraph(context),
        height: 1.35,
      );

  static const linkEmphasis = TextStyle(
    fontSize: 14,
    color: AppColors.primary,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  static const richTextBase14 = TextStyle(fontSize: 14);

  static const validationCaption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.error,
    height: 1.3,
  );

  static TextStyle uploadHint(BuildContext context) => TextStyle(
        fontSize: 12,
        color: AppColors.hint(context),
        height: 1.3,
      );

  static TextStyle uploadAction(BuildContext context) => TextStyle(
        fontSize: 12,
        color: AppColors.onSurface(context),
        decoration: TextDecoration.underline,
        decorationThickness: 1.2,
        height: 1.3,
      );

  static TextStyle pendingMessage(BuildContext context) => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface(context),
        height: 1.4,
      );
}
