import 'package:flutter/material.dart';
import 'package:movie_app/UI/widgets/bottom_sheet_widget.dart';
import 'package:movie_app/UI/widgets/custom_button.dart';
import 'package:movie_app/UI/widgets/custom_text_field.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/utils/assets_manager.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String avaterImage = AssetsManager.avatar1;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.pick_avatar,
          style: AppStyles.medium16Yellow,
        ),
      ),
      body: Padding(
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
                radius: width * 0.1,
                backgroundColor: AppColors.transparentColor,
                child: Image.asset(avaterImage),
              ),
            ),
            SizedBox(height: height * 0.04),
            CustomTextField(
              prefixIcon: Icon(Icons.person, color: AppColors.white),
              hintText: 'John Safwat',
            ),
            SizedBox(height: height * 0.02),
            CustomTextField(
              prefixIcon: Icon(Icons.phone, color: AppColors.white),
              hintText: '01000000000',
            ),
            SizedBox(height: height * 0.032),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context)!.reset_password,
                  style: AppStyles.medium20White,
                ),
              ),
            ),
            Spacer(),
            CustomButton(
              text: AppLocalizations.of(context)!.delete_account,
              textColor: AppColors.white,
              backgroundColor: AppColors.errorRed,
              onPressed: () {},
            ),
            SizedBox(height: height * 0.02),
            CustomButton(
              text: AppLocalizations.of(context)!.update_data,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  void choseAvatar(String imagePath) {
  setState(() {
    avaterImage = imagePath;
  });
  Navigator.pop(context);
}
}
