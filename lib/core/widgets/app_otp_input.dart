import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/text_styles.dart';

class AppOtpInput extends StatefulWidget {
  final bool isLoading;
  final String? errorMessage;
  final ValueChanged<String> onSubmit;
  final VoidCallback onResend;

  const AppOtpInput({
    super.key,
    required this.isLoading,
    this.errorMessage,
    required this.onSubmit,
    required this.onResend,
  });

  @override
  State<AppOtpInput> createState() => _AppOtpInputState();
}

class _AppOtpInputState extends State<AppOtpInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _timer;
  int _seconds = 59;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _seconds = 59);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_seconds <= 0) {
        timer.cancel();
        return;
      }
      setState(() => _seconds--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final otp = _controller.text.trim();
    if (otp.length < 6) return;
    widget.onSubmit(otp);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: 0,
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                maxLength: 6,
                autofocus: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (val) => setState(() {}),
                onSubmitted: (_) => _handleSubmit(),
              ),
            ),
            GestureDetector(
              onTap: () => _focusNode.requestFocus(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  final text = _controller.text;
                  final hasChar = index < text.length;
                  final char = hasChar ? text[index] : '';
                  final isFocused = _focusNode.hasFocus && index == text.length;

                  return Container(
                    width: 48,
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceCard(context),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isFocused
                            ? AppColors.primary
                            : hasChar
                            ? AppColors.otpActiveBorder(context)
                            : AppColors.border(context),
                        width: isFocused ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      char,
                      style: hasChar
                          ? AppTextStyles.otpDigitActive(context)
                          : AppTextStyles.otpDigitInactive(context),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),

        if (widget.errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              widget.errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),

        const SizedBox(height: 32),

        // Timer / Resend
        Center(
          child: _seconds > 0
              ? Text(
                  '${_seconds.toString().padLeft(2, '0')} ${l10n.otpSeconds}',
                  style: AppTextStyles.body(context).copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : TextButton(
                  onPressed: () {
                    _startTimer();
                    widget.onResend();
                  },
                  child: Text(
                    l10n.otpResendCode,
                    style: AppTextStyles.body(context).copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
        ),

        const SizedBox(height: 32),

        // Submit Button
        SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: (_controller.text.length == 6 && !widget.isLoading)
                ? _handleSubmit
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
              disabledForegroundColor: Colors.white.withValues(alpha: 0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: widget.isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    l10n.otpVerifyButton,
                    style: const TextStyle(
                      fontFamily: 'ExpoArabic',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
