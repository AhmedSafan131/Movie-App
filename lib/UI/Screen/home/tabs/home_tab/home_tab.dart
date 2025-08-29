import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/UI/widgets/available_now.dart';
import 'package:movie_app/UI/widgets/home_geners.dart';
import 'package:movie_app/blocs/home_cubit/home_cubit.dart';
import 'package:movie_app/blocs/home_cubit/states.dart';
import 'package:movie_app/utils/app_colors.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;

  HomeTabCubit viewmodel = HomeTabCubit();

  @override
  void initState() {
    super.initState();
    viewmodel.getMovie();
  }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;

    return BlocProvider<HomeTabCubit>(
      create: (context) => viewmodel,
      child: BlocBuilder<HomeTabCubit, HomeStates>(
        builder: (context, state) {
          if (state is HomeTabLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.white,
              ),
            );
          } else if (state is HomeTabErrorState) {
            return Column(
              children: [
                Text(
                  state.error,
                  style: const TextStyle(color: AppColors.white),
                ),
                ElevatedButton(
                    onPressed: () {
                      viewmodel.getMovie();
                    },
                    child: const Text('Try Again'))
              ],
            );
          } else if (state is HomeTabSuccessState) {
            return ListView(
              children: [
                AvailableNow(movies: state.moviesList),
                HomeGenresWidget(
                  genre: 'Action',
                  movies: state.moviesList,
                ),
                HomeGenresWidget(
                  genre: 'Drama',
                  movies: state.moviesList,
                ),
                HomeGenresWidget(
                  genre: 'Adventure',
                  movies: state.moviesList,
                ),
                HomeGenresWidget(
                  genre: 'Mystery',
                  movies: state.moviesList,
                ),
                HomeGenresWidget(
                  genre: 'Documentary',
                  movies: state.moviesList,
                ),
                HomeGenresWidget(
                  genre: 'Thriller',
                  movies: state.moviesList,
                ),
                HomeGenresWidget(
                  genre: 'Animation',
                  movies: state.moviesList,
                ),
                HomeGenresWidget(
                  genre: 'Comedy',
                  movies: state.moviesList,
                ),
                HomeGenresWidget(
                  genre: 'Family',
                  movies: state.moviesList,
                ),
                HomeGenresWidget(
                  genre: 'Music',
                  movies: state.moviesList,
                ),
                HomeGenresWidget(
                  genre: 'War',
                  movies: state.moviesList,
                ),
                HomeGenresWidget(
                  genre: 'Horror',
                  movies: state.moviesList,
                ),
                HomeGenresWidget(
                  genre: 'Fantasy',
                  movies: state.moviesList,
                ),
              ],
            );
            //
          }
          return Container();
        },
      ),
    );
  }
}
// [Adventure, Mystery, Drama, Documentary, Thriller, Action, Animation, Comedy, Family, Music, War, Horror, Musical, Fantasy]
