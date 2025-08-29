import 'package:flutter/material.dart';
import 'package:movie_app/UI/widgets/bottom_sheet_widget.dart';
import 'package:movie_app/UI/widgets/custom_button.dart';
import 'package:movie_app/UI/widgets/custom_text_field.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/utils/app_routes.dart';

class UpdateProfile extends StatefulWidget {
  final String currentName;
  final String currentAvatar;
  final String currentPhone;
  final Function(String, String, String) onProfileUpdated;

  const UpdateProfile({
    super.key,
    required this.currentName,
    required this.currentAvatar,
    required this.currentPhone,
    required this.onProfileUpdated,
  });

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late String avatarImage;
  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    avatarImage = widget.currentAvatar;
    nameController = TextEditingController(text: widget.currentName);
    phoneController = TextEditingController(text: widget.currentPhone);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlack,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.pick_avatar,
          style: AppStyles.medium16Yellow,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.accentYellow),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.02,
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: AppColors.darkGray,
                  context: context,
                  builder: (context) {
                    return BottomSheetWidget(avaterClick: choseAvatar);
                  },
                );
              },
              child: CircleAvatar(
                radius: width * 0.15, // Made avatar bigger
                backgroundColor: AppColors.transparentColor,
                child: Image.asset(avatarImage),
              ),
            ),
            SizedBox(height: height * 0.04),
            CustomTextField(
              controller: nameController,
              prefixIcon: const Icon(Icons.person, color: AppColors.white),
              hintText: 'Enter your name',
            ),
            SizedBox(height: height * 0.02),
            CustomTextField(
              controller: phoneController,
              prefixIcon: const Icon(Icons.phone, color: AppColors.white),
              hintText: 'Enter your phone number',
            ),
            SizedBox(height: height * 0.032),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.resetPassword);
                },
                child: Text(
                  AppLocalizations.of(context)!.reset_password,
                  style: AppStyles.medium20White,
                ),
              ),
            ),
            SizedBox(height: height * 0.04),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.02,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              text: AppLocalizations.of(context)!.delete_account,
              textColor: AppColors.white,
              backgroundColor: AppColors.errorRed,
              onPressed: () {},
            ),
            SizedBox(height: height * 0.02),
            CustomButton(
              text: AppLocalizations.of(context)!.update_data,
              onPressed: () {
                _updateProfile();
              },
            ),
            SizedBox(
              height: height * 0.02,
            ), // Extra padding for bottom safe area
          ],
        ),
      ),
    );
  }

  void choseAvatar(String imagePath) {
    setState(() {
      avatarImage = imagePath;
    });
    Navigator.pop(context);
  }

  void _updateProfile() {
    final newName = nameController.text.trim();
    final newPhone = phoneController.text.trim();

    if (newName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid name'),
          backgroundColor: AppColors.errorRed,
        ),
      );
      return;
    }

    if (newPhone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid phone number'),
          backgroundColor: AppColors.errorRed,
        ),
      );
      return;
    }

    // Call the callback to update the profile tab
    widget.onProfileUpdated(newName, avatarImage, newPhone);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: AppColors.successGreen,
      ),
    );

    // Navigate back to profile tab
    Navigator.of(context).pop();
  }
}
