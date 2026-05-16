import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_media.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

/// Branded splash (#A3090F). UI preview: always continues to [RouteNames.login]
/// after a short delay (driver home is not implemented yet).
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _minSplashDuration = Duration(milliseconds: 900);

  bool _navigated = false;
  bool _minDelayElapsed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<AuthBloc>().add(const AuthCheckRequested());
    });
    Timer(_minSplashDuration, () {
      if (!mounted) return;
      setState(() => _minDelayElapsed = true);
      _maybeNavigate();
    });
  }

  void _maybeNavigate() {
    if (_navigated || !_minDelayElapsed) return;
    _navigated = true;
    // TODO: When driver home exists, route [Authenticated] to RouteNames.driverHome.
    context.go(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) => _maybeNavigate(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: AppSvgImage.asset(
            AppAssets.appLogo,
            width: 142,
            height: 114,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
