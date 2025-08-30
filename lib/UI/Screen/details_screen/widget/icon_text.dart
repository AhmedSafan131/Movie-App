import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_styles.dart';

import '../../../../utils/app_colors.dart';

class IconText extends StatelessWidget {
  String text;
  IconData icon;
   IconText({super.key,required this.text,required this.icon});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin:EdgeInsets.symmetric(horizontal: width*0.01) ,
      padding: EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.01),
      decoration: BoxDecoration(
        color: AppColors.darkGray,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.accentYellow, size: 25),
          SizedBox(width: width*0.02),
          Text(text,style: AppStyles.bold20White, ),
        ],
      ),
    );
  }
}
