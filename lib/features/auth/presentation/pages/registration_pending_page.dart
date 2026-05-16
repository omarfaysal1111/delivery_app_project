import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/app_media.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/auth_primary_button.dart';

class RegistrationPendingPage extends StatelessWidget {
  const RegistrationPendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground(context),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppRasterImage.asset(
                        AppAssets.successPending,
                        width: 132,
                        height: 132,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        l10n.registrationPendingMessage,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.pendingMessage(context),
                      ),
                      const SizedBox(height: 32),
                      AuthPrimaryButton(
                        label: l10n.registerSignIn,
                        onPressed: () => context.go(RouteNames.login),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
