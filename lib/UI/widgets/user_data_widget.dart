import 'package:flutter/material.dart';
import 'package:movie_app/UI/widgets/avatar_item.dart';
import 'package:movie_app/UI/widgets/bottom_sheet_widget.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/models/favorite_movie.dart';
import 'package:movie_app/models/user_model.dart';
import 'package:movie_app/utils/app_styles.dart';

class UserDataWidget extends StatelessWidget {
  const UserDataWidget({
    super.key,
    required this.userModel,
    required this.wishListMovies,
    required this.historyMovies,
  });

  final UserModel userModel;
  final List<FavoriteMovie> wishListMovies;
  final List<FavoriteMovie> historyMovies;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  AvatarItem(
                    size: width * 0.15,
                    avatar: BottomSheetWidget.avatar,
                    index: userModel.avatarId,
                  ),
                  SizedBox(height: (height * 0.02) / 2),
                  FittedBox(
                    child: Text(
                      userModel.name,
                      style: AppStyles.bold20White,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FittedBox(
                    child: Text(
                      '${wishListMovies.length}',
                      style: AppStyles.bold36White,
                    ),
                  ),
                  SizedBox(height: (height * 0.02) / 4),
                  FittedBox(
                    child: Text(
                      AppLocalizations.of(context)!.wish_list,
                      style: AppStyles.bold24White,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FittedBox(
                    child: Text(
                      '${historyMovies.length}',
                      style: AppStyles.bold36White,
                    ),
                  ),
                  SizedBox(height: (height * 0.02) / 4),
                  FittedBox(
                    child: Text(
                      AppLocalizations.of(context)!.history,
                      style: AppStyles.bold24White,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
