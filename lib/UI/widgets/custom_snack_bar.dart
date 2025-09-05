import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
   required bool isError,
    Duration duration = const Duration(seconds: 2),
  }) {
    final snackBar = SnackBar(
      content: Expanded(child: Text(message)),
        backgroundColor:isError?AppColors.errorRed: AppColors.successGreen,
      duration: duration,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
