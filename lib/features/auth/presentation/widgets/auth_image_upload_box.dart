import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';

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
    this.readOnly = false,
    this.imageAsset,
  });

  final File? imageFile;
  final VoidCallback onTap;
  final bool hasError;
  final double size;
  final double borderRadius;
  final bool readOnly;
  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageFile != null;
    final borderColor = hasError
        ? AppColors.fieldError(context)
        : const Color(0xFFA3090F);

    return GestureDetector(
      onTap: readOnly ? null : onTap,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(borderRadius),
          dashPattern: const <double>[8, 4],
          strokeWidth: 2.0,
          color: readOnly ? Colors.transparent : borderColor,
          padding: EdgeInsets.zero,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (hasImage)
                  Image.file(imageFile!, fit: BoxFit.cover)
                else if (imageAsset != null)
                  Image.asset(imageAsset!, fit: BoxFit.cover)
                else if (readOnly)
                  Container(
                    color: AppColors.scaffoldBackground(context),
                    child: Icon(
                      Icons.person,
                      size: size * 0.5,
                      color: AppColors.paragraph(context).withValues(alpha: 0.5),
                    ),
                  ),
                if ((hasImage || imageAsset != null) && !readOnly)
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black26,
                    ),
                  ),
                if (!readOnly)
                  Center(
                    child: Image.asset(
                      AppAssets.profileImageUploadIcon,
                      width: 32,
                      height: 32,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
