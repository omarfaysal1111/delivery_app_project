import 'dart:async';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _minSplashDuration = Duration(milliseconds: 1500);

  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    Timer(_minSplashDuration, () {
      if (!mounted) return;
      _maybeNavigate();
    });
  }

  void _maybeNavigate() {
    if (_navigated) return;
    _navigated = true;
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          return Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                left: (width - 142) / 2,
                top: height * 0.43,
                child: Image.asset(
                  'assets/images/splash_logo.png',
                  width: 142,
                  height: 114,
                  fit: BoxFit.contain,
                ),
              ),
              const PositionedDirectional(
                start: 0,
                end: 0,
                bottom: 0,
                child: _SplashStripes(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SplashStripes extends StatelessWidget {
  const _SplashStripes();

  static const _stripeHeight = 20.0;
  static const _stripeGap = 6.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Padding(
          padding: EdgeInsets.only(top: index == 0 ? 0 : _stripeGap),
          child: Image.asset(
            'assets/images/splash_bottom_stripe.png',
            height: _stripeHeight,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        );
      }),
    );
  }
}
