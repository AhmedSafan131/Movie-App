import 'package:flutter/material.dart';
import 'package:movie_app/UI/Screen/details_screen/widget/icon_text.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';

class SimilarMovieCard extends StatelessWidget {
   String imageUrl;
  String text;
   SimilarMovieCard({super.key, required this.imageUrl,required this.text});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(alignment: Alignment.topLeft,
      children: [Container(
    margin: const EdgeInsets.all(8),
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    ),
    child: Image.network(
    imageUrl,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
    return Container(
    color: Colors.grey[800],
    child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
    );
    },
    ),
    ), Positioned(
        top: 8,
        left: 8,
      child: Container(
      margin:EdgeInsets.symmetric(horizontal: width*0.01,vertical: height*0.01) ,
      padding: EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.005),
      decoration: BoxDecoration(
      color: AppColors.darkGray,
      borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
      children: [
      Icon(Icons.star, color: AppColors.accentYellow, size: 20),
      SizedBox(width: width*0.02),
      Text(text,style: AppStyles.medium14White, ),
      ],
      ),
      ),
    )
    ]);
  }
}
