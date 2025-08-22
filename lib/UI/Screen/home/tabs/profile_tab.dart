import 'package:flutter/material.dart';
import 'package:movie_app/UI/widgets/custom_button.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_routes.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, color: AppColors.accentYellow, size: 80),
          const SizedBox(height: 16),
          Text(
            'Profile Tab',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Manage your profile and settings!',
            style: TextStyle(
              color: AppColors.white.withValues(alpha: 0.7),
              fontSize: 16,
            ),
          ),
          CustomButton(
            text: 'Edit Profile',
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.updateProfileRouteName);
            },
          ),
        ],
      ),
    );
  }
}
