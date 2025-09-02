// import 'package:flutter/material.dart';
// import 'package:movie_app/Api/Api_manger.dart';
// import 'package:movie_app/UI/Screen/details_screen/widget/cast_item.dart';
// import 'package:movie_app/UI/Screen/details_screen/widget/genres_item.dart';
// import 'package:movie_app/UI/Screen/details_screen/widget/icon_text.dart';
// import 'package:movie_app/UI/Screen/details_screen/widget/movie_card.dart';
// import 'package:movie_app/UI/Screen/details_screen/widget/section_title.dart';
// import 'package:movie_app/utils/app_colors.dart';
// import 'package:movie_app/utils/app_styles.dart';
// import 'package:movie_app/utils/assets_manager.dart';
//
// import '../../../models/movies_response.dart';
//
//
// class MovieDetailsPage extends StatefulWidget {
//    Movies movie;
//
//    MovieDetailsPage({super.key, required this.movie});
//
//   @override
//   State<MovieDetailsPage> createState() => _MovieDetailsPageState();
// }
//
// class _MovieDetailsPageState extends State<MovieDetailsPage> {
//   Movies? movie;
//   List<Movies> suggestions = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadMovieData();
//   }
//
//   Future<void> _loadMovieData() async {
//     final movieDetails = await ApiManger.getMovieDetails(widget.movie.id!);
//     final movieSuggestions = await ApiManger.getMovieSuggestions(widget.movie.id!);
//
//     setState(() {
//       movie = movieDetails;
//       suggestions = movieSuggestions;
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     var height = MediaQuery.of(context).size.height;
//      var width = MediaQuery.of(context).size.width;
//     if (isLoading) {
//       return const Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(child: CircularProgressIndicator(color: AppColors.accentYellow)),
//       );
//     }
//
//
//
//     return Scaffold(
//       backgroundColor: AppColors.primaryBlack,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   Image.network(
//                     movie!.largeCoverImage ?? "",
//                     height: height*0.6,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                   Column(
//                     children: [
//                       InkWell(
//                         child: CircleAvatar(
//                           radius: 35,
//                           child: Image.asset(AssetsManager.playIcon),
//                         ),
//                       ),
//                       SizedBox(
//                         height: height*0.15,
//                       ),
//                       Padding(
//                         padding:  EdgeInsets.only(bottom: height*0.02),
//                         child: Text(
//                           movie!.title ?? "",
//                           style: AppStyles.bold24White,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//
//
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//
//                   Text(
//                     "${movie!.year} ",
//                     style: AppStyles.bold20LightGrey,
//                   ),
//                   Padding(
//                     padding:  EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.02),
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         minimumSize:  Size(double.infinity, height*0.07),
//
//                         backgroundColor: AppColors.red,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                       child: Text(
//                         'Watch',
//                         style: AppStyles.bold20White,
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//
//                       IconText(
//                         icon: Icons.favorite,
//                         text: "${movie!.id}",
//                       ),
//                       IconText(
//                         icon: Icons.access_time,
//                         text: "${movie!.runtime} min",
//                       ),
//                       IconText(
//                         icon: Icons.star,
//                         text: "${movie!.rating}",
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//
//                SizedBox(height: height*0.04),
//               SectionTitle(title: "Screen Shots"),
//               SizedBox(
//                 height: height * 0.74,
//                 child: Padding(
//                   padding:  EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.02),
//                   child: Column(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: Image.network(
//                           movie!.largeCoverImage ?? '',
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: height * 0.22,
//                         ),
//                       ),
//                        SizedBox(height: height*0.023),
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: Image.network(
//                           movie!.backgroundImage ?? '',
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: height * 0.22,
//                         ),
//                       ),
//                        SizedBox(height: height*0.017),
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: Image.network(
//                           movie!.backgroundImageOriginal ?? '',
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: height * 0.22,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//
//
//               SectionTitle(title: "Similar"),
//               SizedBox(
//                 height: height * 0.75,
//                 child: GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                     childAspectRatio: 0.65,
//                   ),
//                   itemCount: suggestions.length,
//                   itemBuilder: (context, index) {
//                     final movie = suggestions[index];
//                     return SimilarMovieCard(imageUrl: movie.mediumCoverImage ?? '',text: movie.rating.toString(),);
//                   },
//                 ),
//
//               ),
//
//
//                SizedBox(height: height*0.005),
//
//
//               SectionTitle(title :"Summary"),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: width * 0.02),
//                 child: Text(
//                   movie!.descriptionFull != null && movie!.descriptionFull!.isNotEmpty
//                       ? movie!.descriptionFull!
//                       : "No description available",
//                   style: AppStyles.medium16White,
//                 ),
//               ),
//
//
//
//
//               SectionTitle(title: "Cast"),
//
//
//
//
//               SectionTitle(title: "Genres"),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: width * 0.02),
//                 child: Wrap(
//                   spacing: 8,
//                   runSpacing: 8,
//                   children: movie!.genres!.map((g) => GenresItem(text: g)).toList(),
//                 ),
//               ),
//
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
//
//
//
//
// }















import 'package:flutter/material.dart';
import 'package:movie_app/Api/Api_manger.dart';
import 'package:movie_app/UI/Screen/details_screen/widget/cast_item.dart';
import 'package:movie_app/UI/Screen/details_screen/widget/genres_item.dart';
import 'package:movie_app/UI/Screen/details_screen/widget/icon_text.dart';
import 'package:movie_app/UI/Screen/details_screen/widget/movie_card.dart';
import 'package:movie_app/UI/Screen/details_screen/widget/section_title.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/utils/assets_manager.dart';

import '../../../models/movies_response.dart';

class MovieDetailsPage extends StatefulWidget {
  Movies movie;

  MovieDetailsPage({super.key, required this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Movies? movie;
  List<Movies> suggestions = [];
  List<Cast> castMembers = [];
  bool isLoading = true;
  int likeCount = 0;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _loadMovieData();
  }

  Future<void> _loadMovieData() async {
    final movieDetails = await ApiManger.getMovieDetailsWithCast(widget.movie.id!);
    final movieSuggestions = await ApiManger.getMovieSuggestions(widget.movie.id!);

    setState(() {
      movie = movieDetails;
      suggestions = movieSuggestions;
      castMembers = movieDetails?.cast ?? [];
      likeCount = movieDetails?.likeCount ??
          movieDetails?.downloadCount ??
          (movieDetails?.rating != null ? (movieDetails!.rating! * 100).toInt() : 150);
      isLoading = false;
    });
  }

  void _toggleLike() {
    setState(() {
      if (isLiked) {
        likeCount--;
      } else {
        likeCount++;
      }
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: AppColors.accentYellow)),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.network(
                    movie!.largeCoverImage ?? "",
                    height: height * 0.6,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // Back Arrow
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      InkWell(
                        child: CircleAvatar(
                          radius: 35,
                          child: Image.asset(AssetsManager.playIcon),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.02),
                        child: Text(
                          movie!.title ?? "",
                          style: AppStyles.bold24White,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${movie!.year} ",
                    style: AppStyles.bold20LightGrey,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, height * 0.07),
                        backgroundColor: AppColors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Watch',
                        style: AppStyles.bold20White,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Like Button with dynamic count from API
                      GestureDetector(
                        onTap: _toggleLike,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                          padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.012),
                          decoration: BoxDecoration(
                              color: AppColors.darkGray,
                              borderRadius: BorderRadius.circular(16)
                          ),
                          child: Row(
                            children: [
                              Icon(
                                  isLiked ? Icons.favorite : Icons.favorite_border,
                                  color: isLiked ? AppColors.accentYellow : AppColors.accentYellow,
                                  size: 22
                              ),
                              SizedBox(width: width * 0.015),
                              Text(
                                  _formatNumber(likeCount),
                                  style: AppStyles.bold20White.copyWith(fontSize: 16)
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconText(
                        icon: Icons.access_time,
                        text: "${movie!.runtime ?? 'N/A'} min",
                      ),
                      IconText(
                        icon: Icons.star,
                        text: "${movie!.rating ?? 'N/A'}",
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: height * 0.04),
              SectionTitle(title: "Screen Shots"),
              SizedBox(
                height: height * 0.74,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.02),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          movie!.largeCoverImage ?? '',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: height * 0.22,
                        ),
                      ),
                      SizedBox(height: height * 0.023),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          movie!.backgroundImage ?? '',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: height * 0.22,
                        ),
                      ),
                      SizedBox(height: height * 0.017),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          movie!.backgroundImageOriginal ?? '',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: height * 0.22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SectionTitle(title: "Similar"),
              SizedBox(
                height: height * 0.75,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final movie = suggestions[index];
                    return SimilarMovieCard(
                      imageUrl: movie.mediumCoverImage ?? '',
                      text: movie.rating.toString(),
                    );
                  },
                ),
              ),

              SizedBox(height: height * 0.005),

              SectionTitle(title: "Summary"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Text(
                  movie!.descriptionFull != null && movie!.descriptionFull!.isNotEmpty
                      ? movie!.descriptionFull!
                      : "No description available",
                  style: AppStyles.medium16White,
                ),
              ),

              SizedBox(height: height * 0.03),

              // Cast Section - Updated design similar to the image
              SectionTitle(title: "Cast"),
              if (castMembers.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Column(
                    children: castMembers.map((castMember) {
                      return Container(
                        margin: EdgeInsets.only(bottom: height * 0.015),
                        padding: EdgeInsets.all(width * 0.03),
                        decoration: BoxDecoration(
                          color: AppColors.darkGray.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            // Actor Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                castMember.urlSmallImage ?? '',
                                width: width * 0.15,
                                height: width * 0.15,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: width * 0.15,
                                    height: width * 0.15,
                                    decoration: BoxDecoration(
                                      color: AppColors.darkGray,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                      size: width * 0.08,
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: width * 0.04),
                            // Actor Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name : ${castMember.name ?? 'Unknown Actor'}",
                                    style: AppStyles.bold16White,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: height * 0.005),
                                  Text(
                                    "Character : ${castMember.characterName ?? 'Unknown Character'}",
                                    style: AppStyles.medium14White.copyWith(
                                      color: AppColors.lightGray,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ] else ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Container(
                    height: height * 0.1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.darkGray.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Cast information not available for this movie",
                      style: AppStyles.medium16White.copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],

              SizedBox(height: height * 0.03),

              SectionTitle(title: "Genres"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: movie!.genres!.map((g) => GenresItem(text: g)).toList(),
                ),
              ),

              SizedBox(height: height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to format large numbers (like 1.5K, 10.2K, etc.)
  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}