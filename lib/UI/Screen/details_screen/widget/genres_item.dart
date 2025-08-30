import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';

class GenresItem extends StatelessWidget {
  String text;
   GenresItem({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: width*0.02),
      child: ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkGray,
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(12), )
      ), child: Text(text,style: AppStyles.medium14White,)),
    ) ;
  }
}
