import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/UI/Screen/home/tabs/Home%20Tab/recommended_item.dart';
import 'package:movie_app/models/movies_response.dart';
import 'package:movie_app/utils/assets_manager.dart';

class AvailableNow extends StatefulWidget {
  AvailableNow({super.key, required this.movies});
  List<Movies> movies;
  @override
  State<AvailableNow> createState() => _AvailableNowState();
}

class _AvailableNowState extends State<AvailableNow> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
    image: DecorationImage(
        image: widget.movies[currentIndex].largeCoverImage != null && widget.movies[currentIndex].smallCoverImage!.isNotEmpty
            ? NetworkImage(widget.movies[currentIndex].largeCoverImage!)
            : const AssetImage('assets/images/placeholder.png') as ImageProvider,
        fit: BoxFit.fitHeight,
        opacity: 0.2),
  ),
      height: height * 0.67,
      child: Column(
        children: [
          Image.asset(AssetsManager.avilableNow),
          Expanded(
            child: CarouselSlider.builder(
              itemCount: widget.movies.length,
              itemBuilder: (context, index, realIndex) {
                return RecommendedItem(movie: widget.movies[index]);
              },
              // items:widget.movies
              //     .map<Widget>((movie) => RecommendedItem(movie: movie))
              //     .toList(),
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                animateToClosest: true,
                disableCenter: false,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                viewportFraction: 0.6,
                // enlargeCenterPage: true,
                height: height * 0.64,
                initialPage: currentIndex,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ),
          Image.asset(AssetsManager.watchNow),
        ],
      ),
    );
  }
}
