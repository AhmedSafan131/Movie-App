
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movies_response.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';

class MovieItem extends StatelessWidget {
  final Movies movie;
  const MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: BorderRadius.circular(width * 0.06),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: movie.mediumCoverImage ?? '',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
            placeholder: (context, url) => const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.white, 
                ),
              ),
            ),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error, color: Colors.red),
          ),
    
          
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.005,
              ),
              decoration: BoxDecoration(
                color: AppColors.darkGray,
                borderRadius: BorderRadius.circular(width * 0.02),
              ),
              child: Text(
                '${movie.rating ?? '0'} ⭐',
                style: AppStyles.medium16White,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
