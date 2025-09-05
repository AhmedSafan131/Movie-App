import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_styles.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({
    super.key,
    required this.lineText,
    required this.buttonText,
    required this.onTap,
  });

  final String lineText;
  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            style: AppStyles.medium14White,
            children: [
              TextSpan(text: lineText),
              TextSpan(
                text: buttonText,
                style: AppStyles.medium14Yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
