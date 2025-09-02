import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/utils/app_colors.dart';

class CastItem extends StatelessWidget {
  final String imageUrl;
  final String actorName;
  final String characterName;

  const CastItem({
    super.key,
    required this.imageUrl,
    required this.actorName,
    required this.characterName,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(8),
      width: width * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: width * 0.3,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: width * 0.3,
                  decoration: BoxDecoration(
                    color: AppColors.darkGray,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: width * 0.1,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: height * 0.015),
          Text(
            'Name: $actorName',
            style: AppStyles.medium14White,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            'Character: $characterName',
            style: AppStyles.medium14White.copyWith(
              color: AppColors.lightGray,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}