import 'package:movie_app/models/favorite_movie.dart';

import 'package:movie_app/models/user_model.dart';

abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserModel user;
  final List<FavoriteMovie>favoritesMovies;
  ProfileSuccess({required this.user, required this.favoritesMovies});
}

class ProfileEmpty extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError({required this.message});
}
