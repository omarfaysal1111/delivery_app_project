import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_media.dart';
import '../../../../core/widgets/dashed_border.dart';

/// Profile-photo style upload box (Figma 6323:1301).
///
/// - Always shows a dashed square box.
/// - Centered 32×32 icon, no inline text.
/// - When [imageFile] is set, the image fills the box with a dark overlay
///   and the icon stays on top so the user can tap to replace.
class AuthImageUploadBox extends StatelessWidget {
  const AuthImageUploadBox({
    super.key,
    required this.imageFile,
    required this.onTap,
    this.hasError = false,
    this.size = 100,
    this.borderRadius = 12,
    this.iconAsset = AppAssets.icImageUpload,
    this.iconSize = 32,
  });

  final File? imageFile;
  final VoidCallback onTap;
  final bool hasError;
  final double size;
  final double borderRadius;
  final String iconAsset;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageFile != null;
    final borderColor = hasError
        ? AppColors.fieldError(context)
        : AppColors.uploadDashedBorder(context);

    final iconColor = hasImage ? AppColors.text : AppColors.onSurface(context);

    final box = DashedBorder(
      color: borderColor,
      borderRadius: borderRadius,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (hasImage)
              ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Image.file(imageFile!, fit: BoxFit.cover),
              ),
            if (hasImage)
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.profilePhotoOverlay(context),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            Center(
              child: AppSvgImage.asset(
                iconAsset,
                width: iconSize,
                height: iconSize,
                color: iconColor,
              ),
            ),
          ],
        ),
      ),
    );

    return Material(
      color: AppColors.surfaceCard(context),
      borderRadius: BorderRadius.circular(borderRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: box,
      ),
    );
  }
}
