import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/auth_form_validation.dart';
import '../../../../core/utils/auth_validators.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/auth_back_button.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_scaffold.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key, this.phone});

  final String? phone;

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _otpFocusNode = FocusNode();
  bool _hasAttemptedSubmit = false;

  Timer? _timer;
  int _secondsRemaining = 59;

  @override
  void initState() {
    super.initState();
    _otpFocusNode.addListener(() => setState(() {}));
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _secondsRemaining = 59);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          timer.cancel();
          _timer = null;
        }
      });
    });
  }

  void _onResend() {
    if (_secondsRemaining > 0) return;
    final l10n = AppLocalizations.of(context)!;
    _otpController.clear();
    _formKey.currentState?.reset();
    _startCountdown();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          l10n.otpResentSnackbar,
          style: AppTextStyles.snackBarMessage(context),
        ),
      ),
    );
  }

  void _onVerify() {
    FocusScope.of(context).unfocus();
    setState(() => _hasAttemptedSubmit = true);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    // UI preview — API not wired.
    context.go(RouteNames.registrationPending);
  }

  int get _activeBoxIndex {
    if (!_otpFocusNode.hasFocus) return -1;
    final len = _otpController.text.length;
    if (len >= 6) return 5;
    return len;
  }

  String _charAt(int index) {
    final t = _otpController.text;
    if (index < t.length) return t[index];
    return '-';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AuthScaffold(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthBackButton(),
            const SizedBox(height: 20),
            Text(
              l10n.otpTitle,
              textAlign: TextAlign.start,
              style: AppTextStyles.screenTitle(context),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.otpSubtitle,
              textAlign: TextAlign.start,
              style: AppTextStyles.subtitle(context),
            ),
            const SizedBox(height: 32),
            FormField<String>(
              autovalidateMode: authAutovalidateMode(_hasAttemptedSubmit),
              validator: (_) => AuthValidators.otpSixDigits(
                _otpController.text,
                requiredMessage: l10n.validationOtpRequired,
                invalidMessage: l10n.validationOtpSixDigits,
              ),
              builder: (fieldState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 48,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned.fill(
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: TextField(
                                controller: _otpController,
                                focusNode: _otpFocusNode,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                style: AppTextStyles.hiddenOtpInput,
                                showCursor: false,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counterText: '',
                                ),
                                onChanged: (v) {
                                  fieldState.didChange(v);
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                for (var i = 0; i < 6; i++)
                                  InkWell(
                                    onTap: () => _otpFocusNode.requestFocus(),
                                    borderRadius: BorderRadius.circular(8),
                                    child: _OtpDigitBox(
                                      char: _charAt(i),
                                      active: i == _activeBoxIndex,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (fieldState.hasError)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 6),
                        child: Text(
                          fieldState.errorText ?? '',
                          style: AppTextStyles.validationCaption,
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            AuthPrimaryButton(
              label: l10n.otpVerify,
              onPressed: _onVerify,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.otpTimerSeconds(_secondsRemaining),
                  style: AppTextStyles.timerText(context),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: _onResend,
                  child: Text(
                    l10n.otpResend,
                    style: _secondsRemaining > 0
                        ? AppTextStyles.resendActionDisabled(context)
                        : AppTextStyles.resendAction(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OtpDigitBox extends StatelessWidget {
  const _OtpDigitBox({required this.char, required this.active});

  final String char;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surfaceCard(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: active
              ? AppColors.otpActiveBorder(context)
              : AppColors.border(context),
          width: 0.5,
        ),
      ),
      child: Text(
        char,
        style: active
            ? AppTextStyles.otpDigitActive(context)
            : AppTextStyles.otpDigitInactive(context),
      ),
    );
  }
}
