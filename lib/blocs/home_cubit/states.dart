import 'package:movie_app/models/movies_response.dart';

abstract class HomeStates {}

class HomeInitStates extends HomeStates {}

class HomeTabLoadingState extends HomeStates {}

class HomeTabSuccessState extends HomeStates {
  List<Movies> moviesList;
  HomeTabSuccessState({required this.moviesList});
}

class HomeTabErrorState extends HomeStates {
  String error;
  HomeTabErrorState(this.error);
}
