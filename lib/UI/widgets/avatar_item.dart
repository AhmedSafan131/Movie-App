import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';

class AvatarItem extends StatelessWidget {
  final int index;
  const AvatarItem({
    super.key,
    required this.width,
    required this.avatar,
    required this.index,
  });

  final double width;
  final List<String> avatar;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.accentYellow, width: 2),
        borderRadius: BorderRadius.circular(width * 0.05),
      ),
      child: CircleAvatar(
        backgroundColor: AppColors.transparentColor,
        radius: width * 0.01,
        child: Image.asset(avatar[index]),
      ),
    );
  }
}
