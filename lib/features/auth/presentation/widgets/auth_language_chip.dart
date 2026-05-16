import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/app_media.dart';

class AuthLanguageChip extends StatelessWidget {
  const AuthLanguageChip({
    super.key,
    required this.label,
    required this.flagAsset,
    required this.onTap,
  });

  final String label;
  final String flagAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border(context), width: 0.5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: AppTextStyles.languageChipLabel(context)),
              const SizedBox(width: 4),
              AppSvgImage.asset(flagAsset, width: 16, height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
