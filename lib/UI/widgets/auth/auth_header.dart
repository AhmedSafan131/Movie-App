import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final bool showBackButton;

  const AuthHeader({
    super.key,
    required this.title,
    this.onBackPressed,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBackButton)
          IconButton(
            onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.accentYellow,
              size: 24,
            ),
          ),
        Expanded(
          child: Center(child: Text(title, style: AppStyles.medium18Yellow)),
        ),
        if (showBackButton) const SizedBox(width: 48), // Balance the header
      ],
    );
  }
}
