import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/favorite_movie.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/utils/assets_manager.dart';

class WatchListTab extends StatelessWidget {
  const WatchListTab({super.key, required this.watchList});
  final List<FavoriteMovie> watchList;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return watchList.isEmpty
        ? Center(
            child: Image.asset(AssetsManager.emptyIcon),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              final movie = watchList[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: movie.imageURL ?? '',
                    height: height,
                    width: width * 0.3,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error, color: Colors.red),
                  ),
                ),
                title: Text(
                  movie.name ?? '',
                  style: AppStyles.medium20White,
                ),
              );
            },
            itemCount: watchList.length,
          );
  }
}
