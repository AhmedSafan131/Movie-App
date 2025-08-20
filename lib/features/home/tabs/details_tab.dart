import 'package:flutter/material.dart';
import '../../../utils/app_color.dart';

class DetailsTab extends StatelessWidget {
  const DetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.explore,
            color: AppColors.accentYellow,
            size: 80,
          ),
          const SizedBox(height: 16),
          Text(
            'Details Tab',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Explore movie details and more!',
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
