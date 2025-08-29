import 'package:movie_app/models/movies_response.dart';

abstract class SearchState {}



class SearchLoading extends SearchState {} 

class SearchSuccess extends SearchState {
  final List<Movies> movies; 
  SearchSuccess({required this.movies});
}

class SearchEmpty extends SearchState {} 

class SearchError extends SearchState {
  final String message;
  SearchError({required this.message});
}
