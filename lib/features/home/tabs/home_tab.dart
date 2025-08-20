import 'package:flutter/material.dart';
import '../../../utils/app_color.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home,
            color: AppColors.accentYellow,
            size: 80,
          ),
          const SizedBox(height: 16),
          Text(
            'Home Tab',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Welcome to your movies app!',
            style: TextStyle(
              color: AppColors.white.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
