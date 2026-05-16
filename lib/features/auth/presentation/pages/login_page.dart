import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/localization/context_locale_ext.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/auth_form_validation.dart';
import '../../../../core/utils/auth_validators.dart';
import '../../../../core/widgets/app_media.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/app_language_picker_modal.dart';
import '../widgets/auth_language_chip_align.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/phone_number_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _hasAttemptedSubmit = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    setState(() => _hasAttemptedSubmit = true);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.push(RouteNames.otp, extra: _phoneController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.scaffoldBackground(context),
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              bottom: false,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AuthLanguageChipAlign(
                          label: context.isArabic
                              ? l10n.languageArabicChip
                              : l10n.languageEnglishChip,
                          flagAsset: context.isArabic
                              ? AppAssets.flagEg
                              : AppAssets.flagUsa,
                          onTap: () => showAppLanguagePicker(context),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: AppSvgImage.asset(
                            AppAssets.loginLogo,
                            width: 85,
                            height: 68,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          l10n.loginTitle,
                          textAlign: TextAlign.start,
                          style: AppTextStyles.screenTitle(context),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.loginSubtitle,
                          textAlign: TextAlign.start,
                          style: AppTextStyles.subtitle(context),
                        ),
                        const SizedBox(height: 32),
                        PhoneNumberField(
                          controller: _phoneController,
                          label: l10n.loginPhoneLabel,
                          hintText: l10n.loginPhoneHint,
                          autovalidateMode:
                              authAutovalidateMode(_hasAttemptedSubmit),
                          validator: (v) => AuthValidators.egyptianPhone(
                            v,
                            requiredMessage: l10n.validationPhoneRequired,
                            invalidMessage: l10n.validationPhoneEgyptian,
                          ),
                        ),
                        const SizedBox(height: 20),
                        AuthPrimaryButton(
                          label: l10n.loginSubmit,
                          onPressed: _submit,
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: TextButton(
                            onPressed: () => context.push(RouteNames.register),
                            child: RichText(
                              text: TextSpan(
                                style: AppTextStyles.richTextBase14,
                                children: [
                                  TextSpan(
                                    text: l10n.loginNoAccount,
                                    style: AppTextStyles.footerSecondary(
                                      context,
                                    ),
                                  ),
                                  TextSpan(
                                    text: l10n.loginCreateAccount,
                                    style: AppTextStyles.linkEmphasis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.biometricSoon)),
                    );
                  },
                  icon: AppSvgImage.asset(
                    AppAssets.icFaceId,
                    width: 40,
                    height: 40,
                    color: AppColors.onSurface(context),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
