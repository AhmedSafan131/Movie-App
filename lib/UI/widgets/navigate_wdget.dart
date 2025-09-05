import 'package:flutter/material.dart';
import 'package:movie_app/UI/widgets/custom_button.dart';
import 'package:movie_app/blocs/profile_cubit/profile_view_model.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_routes.dart';

class NavigateWidget extends StatelessWidget {
  const NavigateWidget({
    super.key,
    required this.viewModel,
  });

  final ProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: CustomButton(
            text: AppLocalizations.of(context)!.edit_profile,
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.editProfile),
          ),
        ),
        SizedBox(
          width: width * 0.02,
        ),
        Expanded(
          flex: 1,
          child: CustomButton(
              leftIconDirection: false,
              backgroundColor: AppColors.errorRed,
              textColor: AppColors.white,
              icon: const Icon(
                Icons.logout_rounded,
                color: AppColors.white,
              ),
              text: AppLocalizations.of(context)!.exit,
              onPressed: () {
                viewModel.logout();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.login,
                  (Route<dynamic> route) => false,
                );
              }),
        )
      ],
    );
  }
}
