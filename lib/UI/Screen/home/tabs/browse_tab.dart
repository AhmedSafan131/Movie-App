import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/UI/widgets/movie_item.dart';
import 'package:movie_app/blocs/home_cubit/home_cubit.dart';
import 'package:movie_app/blocs/home_cubit/states.dart';
import 'package:movie_app/models/movies_response.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> with TickerProviderStateMixin {
  late TabController _tabController;
  Set<String> genres = {};
  List<Movies> allMovies = [];
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 0, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _extractGenres(List<Movies> movies) {
    genres.clear();
    for (var movie in movies) {
      if (movie.genres != null) {
        genres.addAll(movie.genres!);
      }
    }
    // Convert to sorted list for consistent ordering
    var sortedGenres = genres.toList()..sort();
    genres = sortedGenres.toSet();

    // Update tab controller with new length
    _tabController.dispose();
    _tabController = TabController(length: genres.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedTabIndex = _tabController.index;
      });
    });
  }

  List<Movies> _getMoviesByGenre(String genre) {
    return allMovies
        .where((movie) => movie.genres?.contains(genre) ?? false)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocProvider<HomeTabCubit>(
      create: (context) => HomeTabCubit()..getMovie(),
      child: BlocBuilder<HomeTabCubit, HomeStates>(
        builder: (context, state) {
          if (state is HomeTabLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.accentYellow,
              ),
            );
          } else if (state is HomeTabErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.error,
                    style: const TextStyle(color: AppColors.white),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeTabCubit>().getMovie();
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else if (state is HomeTabSuccessState) {
            // Extract genres on first load
            if (allMovies.isEmpty) {
              allMovies = state.moviesList;
              _extractGenres(state.moviesList);
            }

            if (genres.isEmpty) {
              return const Center(
                child: Text(
                  'No genres found',
                  style: TextStyle(color: AppColors.white),
                ),
              );
            }

            return Column(
              children: [
                // Browse Title
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.04,
                    top: height * 0.04,
                    bottom: height * 0.02,
                  ),
                ),

                // Genre Tabs
                Container(
                  height: 45,
                  margin: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: genres.length,
                    itemBuilder: (context, index) {
                      final genre = genres.elementAt(index);
                      final isSelected = selectedTabIndex == index;
                      return Container(
                        margin: EdgeInsets.only(right: width * 0.03),
                        child: GestureDetector(
                          onTap: () {
                            _tabController.animateTo(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.04,
                              vertical: height * 0.01,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.accentYellow
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                              border: isSelected
                                  ? null
                                  : Border.all(
                                      color: AppColors.accentYellow,
                                      width: 1,
                                    ),
                            ),
                            child: Text(
                              genre,
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.primaryBlack
                                    : AppColors.accentYellow,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: height * 0.02),

                // Movies Grid
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: genres.map((genre) {
                      final genreMovies = _getMoviesByGenre(genre);
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        child: genreMovies.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.movie,
                                      color: AppColors.white.withOpacity(0.5),
                                      size: 60,
                                    ),
                                    SizedBox(height: height * 0.02),
                                    Text(
                                      'No movies found for $genre',
                                      style: TextStyle(
                                        color: AppColors.white.withOpacity(0.7),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: height * 0.02,
                                  crossAxisSpacing: width * 0.03,
                                  childAspectRatio: 1 / 1.5,
                                ),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      // Handle movie tap
                                    },
                                    child: MovieItem(movie: genreMovies[index]),
                                  );
                                },
                                itemCount: genreMovies.length,
                              ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
