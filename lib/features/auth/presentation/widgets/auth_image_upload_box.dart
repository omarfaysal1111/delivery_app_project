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
    this.readOnly = false,
  });

  final File? imageFile;
  final VoidCallback onTap;
  final bool hasError;
  final double size;
  final double borderRadius;
  final String iconAsset;
  final double iconSize;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageFile != null;
    final borderColor = hasError
        ? AppColors.fieldError(context)
        : AppColors.uploadDashedBorder(context);

    final iconColor = hasImage ? AppColors.text : AppColors.onSurface(context);

    final box = DashedBorder(
      color: readOnly ? Colors.transparent : borderColor,
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
              )
            else if (readOnly)
              Container(
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBackground(context),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Icon(
                  Icons.person,
                  size: size * 0.5,
                  color: AppColors.paragraph(context).withValues(alpha: 0.5),
                ),
              ),
            if (hasImage && !readOnly)
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.profilePhotoOverlay(context),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            if (!readOnly)
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
      color: readOnly
          ? AppColors.scaffoldBackground(context)
          : AppColors.surfaceCard(context),
      borderRadius: BorderRadius.circular(borderRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: readOnly ? null : onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: box,
      ),
    );
  }
}
