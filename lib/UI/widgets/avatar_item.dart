import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';

class AvatarItem extends StatelessWidget {
  final int index;
  const AvatarItem({
    super.key,
    required this.size,
    required this.avatar,
    required this.index,
  });

  final double size;
  final List<String> avatar;

  @override
  Widget build(BuildContext context) {

    return CircleAvatar(
      backgroundColor: AppColors.transparentColor,
      radius: size,
      backgroundImage: AssetImage(avatar[index]),
    );
  }
}
