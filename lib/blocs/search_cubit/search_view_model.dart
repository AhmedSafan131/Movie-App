import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Api/api_manger.dart';
import 'package:movie_app/blocs/search_cubit/search_state.dart';

class SearchViewModel extends Cubit<SearchState> {
  SearchViewModel() : super(SearchLoading());
  void getMovie(String movieTitle) async {
    if (movieTitle.isEmpty) {
      emit(SearchSuccess(movies: []));
      return;
    }
    try {
      emit(SearchLoading());
      var response = await ApiManger.getMovieByName(movieTitle);

      if (response == null) {
        emit(SearchError(message: 'No response from server'));
        return;
      }

      if (response.status == 'error') {
        emit(SearchError(message: response.statusMessage!));
      } else if (response.status == 'ok') {
        emit(SearchSuccess(movies: response.data?.movies ?? []));
      }
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }
}
