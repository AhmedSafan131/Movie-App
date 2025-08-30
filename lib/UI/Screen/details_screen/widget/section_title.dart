import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_styles.dart';

class SectionTitle extends StatelessWidget {
  String title;
   SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: width*0.02, vertical: height*0.02),
      child: Text(
        title,
        style:AppStyles.bold24White),

    );
  }
}
