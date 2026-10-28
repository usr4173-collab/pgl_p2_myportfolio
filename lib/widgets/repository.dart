import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';

/// "Más sobre mí" tab: image, name, quote and QR code with the link.
class Repository extends StatelessWidget {
  const Repository({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      child: Column(
        children: [
          Image.asset(
            AppStrings.repositoryImage,
            width: AppSizes.repositoryImageWidth,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: AppSizes.spacing),
          const Text(
            AppStrings.repositoryName,
            style: TextStyle(
              fontSize: AppSizes.titleSize,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: AppSizes.padding),
          const Text(
            AppStrings.repositoryQuote,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSizes.textSize,
              fontStyle: FontStyle.italic,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: AppSizes.spacingLarge),
          const _QrCode(),
        ],
      ),
    );
  }
}

/// QR code that points to AppStrings.repositoryUrl (orange frame).
class _QrCode extends StatelessWidget {
  const _QrCode();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      ),
      child: QrImageView(
        data: AppStrings.repositoryUrl,
        version: QrVersions.auto,
        size: AppSizes.qrSize,
        backgroundColor: Colors.white,
      ),
    );
  }
}
