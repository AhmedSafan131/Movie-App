import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_app/UI/widgets/custom_button.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:movie_app/UI/Screen/profile/update_profile.dart';
import 'package:movie_app/blocs/user/user_bloc.dart';
import 'package:movie_app/blocs/user/user_event.dart';
import 'package:movie_app/blocs/user/user_state.dart';
import 'package:movie_app/models/user_model.dart';
import 'package:movie_app/repositories/user_repository.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBlack,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.accentYellow),
            );
          }

          if (state is UserError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: AppStyles.medium16White,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<UserBloc>().add(const LoadUser());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is UserLoaded) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50), // Space for status bar
                  // User Information Section
                  _buildUserInfoSection(state.user),

                  const SizedBox(height: 24),

                  // Action Buttons
                  _buildActionButtons(context, state.user),

                  const SizedBox(height: 30),

                  // Secondary Navigation Tabs
                  _buildSecondaryTabs(),

                  const SizedBox(height: 20),

                  // Content Area
                  Expanded(child: _buildContentArea()),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(color: AppColors.accentYellow),
          );
        },
      ),
    );
  }

  Widget _buildUserInfoSection(UserModel user) {
    return Row(
      children: [
        // Profile Picture and Name
        Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: Image.asset(
                  user.avatar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.accentYellow,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: AppColors.primaryBlack,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(user.name, style: AppStyles.bold16White),
          ],
        ),

        const SizedBox(width: 16),

        // Statistics
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Statistics
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Wish List
                  Column(
                    children: [
                      Text('12', style: AppStyles.bold24White),
                      const SizedBox(height: 20),
                      Text(
                        'Wish List',
                        style: AppStyles.bold16White.copyWith(
                          color: AppColors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),

                  // History
                  Column(
                    children: [
                      Text('10', style: AppStyles.bold24White),
                      const SizedBox(height: 20),
                      Text(
                        'History',
                        style: AppStyles.bold16White.copyWith(
                          color: AppColors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, UserModel user) {
    return Row(
      children: [
        // Edit Profile Button (Bigger)
        Expanded(
          flex: 3,
          child: CustomButton(
            text: 'Edit Profile',
            onPressed: () => _onEditProfilePressed(context, user),
            backgroundColor: AppColors.accentYellow,
            textColor: AppColors.primaryBlack,
          ),
        ),

        const SizedBox(width: 12),

        // Exit Button
        Expanded(
          flex: 2,
          child: CustomButton(
            text: 'Exit',
            onPressed: () => _onExitPressed(context),
            backgroundColor: AppColors.errorRed,
            textColor: AppColors.white,
            icon: const Icon(
              Icons.exit_to_app,
              color: AppColors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  void _onEditProfilePressed(BuildContext context, UserModel user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UpdateProfile(
          currentName: user.name,
          currentAvatar: user.avatar,
          currentPhone: user.phone,
          onProfileUpdated: (newName, newAvatar, newPhone) {
            context.read<UserBloc>().add(
              UpdateUser(
                user.copyWith(
                  name: newName,
                  avatar: newAvatar,
                  phone: newPhone,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onExitPressed(BuildContext context) {
    _showLogoutDialog(context);
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.darkGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text('Exit', style: AppStyles.bold20White),
          content: Text(
            'Are you sure you want to exit?',
            style: AppStyles.medium16White,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: AppStyles.medium16White),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(
                  context,
                ).pushReplacementNamed(AppRoutes.onboarding);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.errorRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Exit', style: AppStyles.medium16White),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSecondaryTabs() {
    return Row(
      children: [
        // Watch List Tab
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedTabIndex = 0),
            child: Column(
              children: [
                Icon(
                  Icons.list,
                  color: selectedTabIndex == 0
                      ? AppColors.accentYellow
                      : AppColors.white.withOpacity(0.7),
                  size: 24,
                ),
                const SizedBox(height: 8),
                Text(
                  'Watch List',
                  style: AppStyles.medium16White.copyWith(
                    color: selectedTabIndex == 0
                        ? AppColors.accentYellow
                        : AppColors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: selectedTabIndex == 0
                        ? AppColors.accentYellow
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ),

        // History Tab
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedTabIndex = 1),
            child: Column(
              children: [
                Icon(
                  Icons.folder,
                  color: selectedTabIndex == 1
                      ? AppColors.accentYellow
                      : AppColors.white.withOpacity(0.7),
                  size: 24,
                ),
                const SizedBox(height: 8),
                Text(
                  'History',
                  style: AppStyles.medium16White.copyWith(
                    color: selectedTabIndex == 1
                        ? AppColors.accentYellow
                        : AppColors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: selectedTabIndex == 1
                        ? AppColors.accentYellow
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentArea() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty State Illustration
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset(
              'assets/images/Empty.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to custom illustration if image is not found
                return Container(
                  width: 120,
                  height: 120,
                  child: Stack(
                    children: [
                      // Popcorn Bucket
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                          width: 60,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [AppColors.accentYellow, AppColors.white],
                              stops: const [0.0, 0.5],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              // Popcorn kernels
                              Positioned(
                                top: 10,
                                left: 8,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 15,
                                right: 8,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 25,
                                left: 12,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 35,
                                right: 10,
                                child: Container(
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Soda Cup
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 50,
                          height: 70,
                          decoration: BoxDecoration(
                            color: AppColors.accentYellow,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              // Cup lid
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              // Straw
                              Positioned(
                                top: 5,
                                right: 8,
                                child: Container(
                                  width: 3,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          Text(
            selectedTabIndex == 0
                ? 'No movies in your watch list'
                : 'No movies in your history',
            style: AppStyles.medium16White.copyWith(
              color: AppColors.white.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
