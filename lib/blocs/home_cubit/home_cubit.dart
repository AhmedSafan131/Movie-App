import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Api/Api_manger.dart';
import 'package:movie_app/blocs/home_cubit/states.dart';

class HomeTabCubit extends Cubit<HomeStates> {
  HomeTabCubit() : super(HomeInitStates());
  void getMovie() async {
    try {
      emit(HomeTabLoadingState());
      var response = await ApiManger.getMoviesList();
      if (response.status == 'error') {
        emit(HomeTabErrorState(response.statusMessage ?? ''));
      }
      if (response.status == 'ok') {
        emit(HomeTabSuccessState(moviesList: response.data!.movies!));
      }
    } catch (e) {
      emit(HomeTabErrorState(e.toString()));
    }
  }
}
