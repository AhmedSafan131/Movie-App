import 'package:flutter/material.dart';
import 'package:movie_app/models/movies_response.dart';
import 'package:movie_app/utils/app_colors.dart';

class RecommendedItem extends StatelessWidget {
  const RecommendedItem({super.key, required this.movie});
  final Movies movie;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            height: height * 0.6,
            child: Image.network(
              movie.largeCoverImage?? '',
              errorBuilder: (context, error, stackTrace) {
    return const Icon(Icons.broken_image, size: 48, color: Colors.grey);
  },
              fit: BoxFit.cover,
            )),
        Container(
          width: width * 0.15,
          decoration: BoxDecoration(
              color: AppColors.primaryBlack,
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.02,
          ),
          margin: EdgeInsets.symmetric(
              horizontal: width * 0.01, vertical: height * 0.007),
          child: Row(children: [
            Text(
              '${movie.rating}',
              style: const TextStyle(color: Colors.white),
            ),
            const Icon(
              Icons.star,
              color: AppColors.yellowColor,
              size: 16,
            ),
          ]),
        )
      ],
    );
  }
}
