import 'package:flutter/material.dart';
import 'package:movie_app/UI/widgets/movie_item.dart';
import 'package:movie_app/models/movies_response.dart';

class SearchMovieItem extends StatelessWidget {
  final List<Movies> searchMoviesList;
  final VoidCallback movieOnClick;
  const SearchMovieItem(
      {super.key, required this.searchMoviesList, required this.movieOnClick});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: height * 0.02,
          crossAxisSpacing: width * 0.02,
          childAspectRatio: 1 / 1.5),
      itemBuilder: (context, index) {
        return InkWell(
            onTap: movieOnClick,
            child: MovieItem(movie: searchMoviesList[index]));
      },
      itemCount: searchMoviesList.length,
    );
  }
}
