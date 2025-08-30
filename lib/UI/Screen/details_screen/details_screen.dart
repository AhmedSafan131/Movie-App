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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMovieData();
  }

  Future<void> _loadMovieData() async {
    final movieDetails = await ApiManger.getMovieDetails(widget.movie.id!);
    final movieSuggestions = await ApiManger.getMovieSuggestions(widget.movie.id!);

    setState(() {
      movie = movieDetails;
      suggestions = movieSuggestions;
      isLoading = false;
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
                    height: height*0.6,
                    width: double.infinity,
                    fit: BoxFit.cover,
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
                        height: height*0.15,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(bottom: height*0.02),
                        child: Text(
                          movie!.title ?? "",
                          style: AppStyles.bold24White,
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
                    padding:  EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.02),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize:  Size(double.infinity, height*0.07),

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

                      IconText(
                        icon: Icons.favorite,
                        text: "${movie!.id}",
                      ),
                      IconText(
                        icon: Icons.access_time,
                        text: "${movie!.runtime} min",
                      ),
                      IconText(
                        icon: Icons.star,
                        text: "${movie!.rating}",
                      ),
                    ],
                  ),
                ],
              ),

               SizedBox(height: height*0.04),
              SectionTitle(title: "Screen Shots"),
              SizedBox(
                height: height * 0.74,
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.02),
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
                       SizedBox(height: height*0.023),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          movie!.backgroundImage ?? '',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: height * 0.22,
                        ),
                      ),
                       SizedBox(height: height*0.017),
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
                    return SimilarMovieCard(imageUrl: movie.mediumCoverImage ?? '',text: movie.rating.toString(),);
                  },
                ),

              ),


               SizedBox(height: height*0.005),


              SectionTitle(title :"Summary"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Text(
                  movie!.descriptionFull != null && movie!.descriptionFull!.isNotEmpty
                      ? movie!.descriptionFull!
                      : "No description available",
                  style: AppStyles.medium16White,
                ),
              ),




              SectionTitle(title: "Cast"),




              SectionTitle(title: "Genres"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: movie!.genres!.map((g) => GenresItem(text: g)).toList(),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }







}
