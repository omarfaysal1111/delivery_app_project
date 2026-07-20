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
        title: Text(
          l10n.drawerReviews,
          style: AppTextStyles.appBarTitle(context),
        ),
        centerTitle: false,
        titleSpacing: 4.0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3, // Mock count
        itemBuilder: (context, index) {
          return ReviewCard(index: index, l10n: l10n);
        },
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.index, required this.l10n});

  final int index;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 91,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.mockReviewUserName((index + 1).toString()),
                      style: AppTextStyles.body(
                        context,
                      ).copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      l10n.mockReviewDate((index + 6).toString()),
                      style: AppTextStyles.caption(context).copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.paragraph(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        5,
                        (starIndex) => Padding(
                          padding: EdgeInsetsDirectional.only(
                            end: starIndex < 4 ? 4.0 : 0.0,
                          ),
                          child: Icon(
                            Icons.star_rounded,
                            size: 12,
                            color: starIndex < 4
                                ? AppColors.ratingStar
                                : AppColors.border(context),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        l10n.mockReviewText,
                        style: AppTextStyles.body(context).copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.paragraph(context),
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 0.5,
            thickness: 0.5,
            color: AppColors.border(context),
          ),
        ],
      ),
    );
  }
}
