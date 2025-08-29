import 'package:flutter/material.dart';
import 'package:movie_app/UI/Screen/home/tabs/home_tab/recommended_item.dart';
import 'package:movie_app/models/movies_response.dart';
import 'package:movie_app/utils/app_colors.dart';

class HomeGenresWidget extends StatelessWidget {
  final List<Movies>? movies;
  final String genre;
  const HomeGenresWidget({super.key, this.movies, required this.genre});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final filteredMovies = (movies != null)
        ? movies!
            .where((movie) => movie.genres?.contains(genre) ?? false)
            .toList()
        : movies ?? [];
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.01),
          child: Row(
            children: [
              Text(genre, style: Theme.of(context).textTheme.headlineMedium),
              const Spacer(),
              const Text(
                'See More',
                style: TextStyle(color: AppColors.yellowColor, fontSize: 16),
              ),
              SizedBox(
                width: width * 0.02,
              ),
              const Icon(
                Icons.arrow_forward,
                color: AppColors.yellowColor,
                size: 15,
              )
            ],
          ),
        ),
        SizedBox(height: height * 0.02),
        SizedBox(
          height: height * 0.3,
          child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return RecommendedItem(
                  movie: filteredMovies[index],
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(width: width * 0.03),
              itemCount: filteredMovies.length),
        ),
      ],
    );
  }
}
