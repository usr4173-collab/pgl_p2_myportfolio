import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';


class Repository extends StatefulWidget {
  const Repository({super.key});

  @override
  State<Repository> createState() => _RepositoryState();
}

class _RepositoryState extends State<Repository> {
  static const int pageCount = 2;
  int _currentPage = 0;
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            onPageChanged: (page) => setState(() => _currentPage = page),
            children: [
              _QuoteCard(
                liked: _liked,
                onLike: () => setState(() => _liked = !_liked),
              ),
              const _QrCard(),
            ],
          ),
        ),
        _PageDots(count: pageCount, current: _currentPage),
        const SizedBox(height: AppSizes.spacingLarge),
      ],
    );
  }
}

/// Card with the image, the name, a heart button and the quote.
class _QuoteCard extends StatelessWidget {
  final bool liked;
  final VoidCallback onLike;

  const _QuoteCard({required this.liked, required this.onLike});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppSizes.paddingLarge),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: AppSizes.repositoryImageHeight,
              color: AppColors.lightBlue,
              padding: const EdgeInsets.all(AppSizes.paddingLarge),
              child: Image.asset(AppStrings.repositoryImage, fit: BoxFit.contain),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          AppStrings.repositoryName,
                          style: TextStyle(
                            fontSize: AppSizes.titleSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onLike,
                        icon: Icon(
                          liked ? Icons.favorite : Icons.favorite_border,
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    AppStrings.repositoryQuote,
                    style: TextStyle(
                      fontSize: AppSizes.textSize,
                      fontStyle: FontStyle.italic,
                      color: AppColors.greyText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Card with the QR code that points to AppStrings.repositoryUrl.
class _QrCard extends StatelessWidget {
  const _QrCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppSizes.paddingLarge),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.paddingLarge),
          child: Column(
            children: [
              const Text(
                AppStrings.qrTitle,
                style: TextStyle(fontSize: AppSizes.titleSize, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSizes.spacing),
              Container(
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
              ),
              const SizedBox(height: AppSizes.spacing),
              const Text(
                AppStrings.qrText,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.greyText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dots that show which card is visible (the active one is longer and blue).
class _PageDots extends StatelessWidget {
  final int count;
  final int current;

  const _PageDots({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final bool active = index == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? AppColors.primary : AppColors.disabled,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
