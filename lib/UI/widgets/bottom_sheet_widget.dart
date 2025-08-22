import 'package:flutter/material.dart';
import 'package:movie_app/utils/assets_manager.dart';
import 'package:movie_app/UI/widgets/avatar_item.dart';

class BottomSheetWidget extends StatelessWidget {
  final Function(String) avaterClick;
  const BottomSheetWidget({super.key, required this.avaterClick});

  static const List<String> avatar = [
    AssetsManager.avatar1,
    AssetsManager.avatar2,
    AssetsManager.avatar3,
    AssetsManager.avatar4,
    AssetsManager.avatar5,
    AssetsManager.avatar6,
    AssetsManager.avatar7,
    AssetsManager.avatar8,
    AssetsManager.avatar9,
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width * 0.95,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.01,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: height * 0.01,
          crossAxisSpacing: width * 0.02,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              avaterClick(avatar[index]);
            },
            child: AvatarItem(width: width, avatar: avatar, index: index),
          );
        },
        itemCount: avatar.length,
      ),
    );
  }
}
