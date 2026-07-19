import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
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

  void _verify() {
    FocusManager.instance.primaryFocus?.unfocus();
    final otp = _controller.text.trim();
    if (otp.length < 6) return;
    
    context.read<AuthCubit>().verifyOtp(otp);
  }

  void _resend() {
    if (_seconds > 0) return;
    _controller.clear();
    setState(() => _seconds = 60);
    _timer?.cancel();
    _startTimer();
    
    final phone = context.read<AuthCubit>().phoneNumber;
    if (phone != null) {
      context.read<AuthCubit>().submitPhone(phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground(context),
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listenWhen: (prev, curr) => curr is AuthOtpVerified || curr is AuthError || curr is AuthPhoneSubmitted,
          listener: (context, state) {
            if (state is AuthOtpVerified) {
              if (state.isNewDriver) {
                context.go('/register');
              } else {
                context.go('/home');
              }
            } else if (state is AuthPhoneSubmitted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    l10n.otpResentSnackbar,
                    style: AppTextStyles.snackBarMessage(context),
                  ),
                ),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: AppTextStyles.snackBarMessage(context),
                  ),
                ),
              );
            }
          },
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/login'); // Fallback to login if accessed directly
                        }
                      },
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: AppColors.onSurface(context),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    l10n.otpTitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.screenTitle(context),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.otpSubtitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subtitle(context),
                  ),
                  const SizedBox(height: 32),
                  _OtpBoxes(controller: _controller, focusNode: _focusNode),
                  const SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return BlocBuilder<AuthCubit, AuthState>(
                        buildWhen: (prev, curr) => curr is AuthLoading || curr is AuthInitial || curr is AuthError || curr is AuthOtpVerified || curr is AuthPhoneSubmitted,
                        builder: (context, state) {
                          final isLoading = state is AuthLoading;
                          final isComplete = _controller.text.length == 6;
                          return ElevatedButton(
                            onPressed: isLoading || !isComplete ? null : _verify,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              disabledBackgroundColor: AppColors.hint(context),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.all(16.0),
                              elevation: 0,
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    l10n.otpVerifyButton,
                                    style: AppTextStyles.primaryButtonLabel.copyWith(
                                      color: isComplete ? AppColors.text : AppColors.paragraph(context),
                                    ),
                                  ),
                          );
                        },
                      );
                    }
                  ),
                  const SizedBox(height: 24),
                  _ResendRow(seconds: _seconds, onResend: _resend, l10n: l10n),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OtpBoxes extends StatelessWidget {
  const _OtpBoxes({required this.controller, required this.focusNode});

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        children: [
          Positioned.fill(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                autofocus: true,
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
                showCursor: false,
                style: AppTextStyles.hiddenOtpInput,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              final value = controller.text;
              return Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    final active = index == value.length.clamp(0, 5);
                    final char = index < value.length ? value[index] : '-';
                    return InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: focusNode.requestFocus,
                      child: Container(
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
                      ),
                    );
                  }),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ResendRow extends StatelessWidget {
  const _ResendRow({required this.seconds, required this.onResend, required this.l10n});

  final int seconds;
  final VoidCallback onResend;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${seconds.toString().padLeft(2, '0')} ${l10n.otpSeconds}',
          style: AppTextStyles.timerText(context),
        ),
        const SizedBox(width: 4),
        TextButton(
          onPressed: seconds == 0 ? onResend : null,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            l10n.otpResendCode,
            style: AppTextStyles.textLink(
              context,
            ).copyWith(
              color: seconds > 0 ? AppColors.paragraph(context) : AppColors.primary, 
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
