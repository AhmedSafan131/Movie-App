import 'package:flutter/material.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    double iconSize = width * 0.1;
    return TabBar(
        dividerColor: AppColors.transparentColor,
        indicatorColor: AppColors.yellowColor,
        unselectedLabelStyle: AppStyles.medium20White,
        labelStyle: AppStyles.medium20White,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(
            text: AppLocalizations.of(context)!.watch_list,
            icon: Icon(
              Icons.list,
              size: iconSize,
              color: AppColors.yellowColor,
            ),
          ),
          Tab(
            text: AppLocalizations.of(context)!.history,
            icon: Icon(
              Icons.folder,
              size: iconSize,
              color: AppColors.yellowColor,
            ),
          )
        ]);
  }
}
