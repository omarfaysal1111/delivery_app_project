import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:delivery_app_project/core/theme/app_colors.dart';
import 'package:delivery_app_project/core/theme/text_styles.dart';
import 'package:delivery_app_project/l10n/app_localizations.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

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
        title: Text(l10n.drawerReviews, style: AppTextStyles.appBarTitle(context)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star_border_rounded,
              size: 64,
              color: AppColors.hint(context),
            ),
            const SizedBox(height: 16),
            Text(
              "No reviews yet.", // Typically l10n
              style: AppTextStyles.body(context).copyWith(
                color: AppColors.paragraph(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
