import 'package:flutter/material.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_style.dart';

/// Data model for onboarding page content
class OnboardingPageData {
  final String title;
  final String description;
  final String image;
  final bool showBackButton;
  final String primaryButtonText;

  const OnboardingPageData({
    required this.title,
    required this.description,
    required this.image,
    required this.showBackButton,
    required this.primaryButtonText,
  });
}

/// Individual onboarding page widget
class OnboardingPage extends StatelessWidget {
  final OnboardingPageData data;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final bool isLastPage;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.onNext,
    required this.onBack,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Full background image
        Positioned.fill(
          child: Image.asset(
            data.image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Fallback placeholder if image is not found
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.accentYellow.withOpacity(0.3),
                      AppColors.primaryBlack,
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.movie,
                    size: 80,
                    color: AppColors.accentYellow,
                  ),
                ),
              );
            },
          ),
        ),

        // Content overlay - different for first screen vs others
        if (data.showBackButton) ...[
          // Container for screens 2-6
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
              decoration: const BoxDecoration(
                color: AppColors.primaryBlack,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    data.title,
                    style: AppTextStyles.h2.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  // Description
                  Text(
                    data.description,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 15,
                      height: 1.4,
                      color: AppColors.white.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  // Buttons
                  Column(
                    children: [
                      // Primary button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: onNext,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentYellow,
                            foregroundColor: AppColors.primaryBlack,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            data.primaryButtonText,
                            style: AppTextStyles.button.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      // Back button
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: onBack,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.accentYellow,
                            side: const BorderSide(
                              color: AppColors.accentYellow,
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Back",
                            style: AppTextStyles.button.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.accentYellow,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          // No container for first screen - content directly over image
          Positioned(
            left: 24,
            right: 24,
            bottom: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  data.title,
                  style: AppTextStyles.h2.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                    color: AppColors.white,
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // Description
                Text(
                  data.description,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 18,
                    height: 1.4,
                    color: AppColors.white,
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // Primary button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentYellow,
                      foregroundColor: AppColors.primaryBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      data.primaryButtonText,
                      style: AppTextStyles.button.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
