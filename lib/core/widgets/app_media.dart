import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';

class AppSvgImage extends StatelessWidget {
  const AppSvgImage.asset(
    this.assetName, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.semanticsLabel,
    this.color,
  });

  final String assetName;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String? semanticsLabel;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      fit: fit,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      semanticsLabel: semanticsLabel,
      placeholderBuilder: (context) => _AssetFallback(
        width: width,
        height: height,
        icon: Icons.image_outlined,
      ),
      errorBuilder: (context, error, stackTrace) {
        if (kDebugMode) {
          developer.log(
            'AppSvgImage failed to load asset=$assetName',
            name: 'AppSvgImage',
            error: error,
            stackTrace: stackTrace,
          );
        }
        return _AssetFallback(
          width: width,
          height: height,
          icon: Icons.broken_image_outlined,
        );
      },
    );
  }
}

class AppRasterImage extends StatelessWidget {
  const AppRasterImage.asset(
    this.assetName, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  final String assetName;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetName,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        if (kDebugMode) {
          developer.log(
            'AppRasterImage failed to load asset=$assetName',
            name: 'AppRasterImage',
            error: error,
            stackTrace: stackTrace,
          );
        }
        return _AssetFallback(
          width: width,
          height: height,
          icon: Icons.broken_image_outlined,
        );
      },
    );
  }
}

class _AssetFallback extends StatelessWidget {
  const _AssetFallback({
    required this.width,
    required this.height,
    required this.icon,
  });

  final double? width;
  final double? height;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 24,
      height: height ?? 24,
      child: Icon(
        icon,
        size: 20,
        color: AppColors.hint(context),
      ),
    );
  }
}
