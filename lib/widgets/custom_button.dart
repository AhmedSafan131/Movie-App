import 'package:flutter/material.dart';
import '../utils/app_color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.width,
    this.height = 50,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 12,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = backgroundColor ?? AppColors.accentYellow;
    final textColorFinal = textColor ?? AppColors.primaryBlack;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: buttonColor,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: _buildButtonContent(textColorFinal),
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: textColorFinal,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: _buildButtonContent(textColorFinal),
            ),
    );
  }

  Widget _buildButtonContent(Color textColor) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
