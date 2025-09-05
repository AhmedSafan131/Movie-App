import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Api/api_manger.dart';
import 'package:movie_app/blocs/auth_cubit/login/login_view_model.dart';
import 'package:movie_app/blocs/profile_cubit/profile_state.dart';
import 'package:movie_app/models/favorite_movie.dart';

import 'package:movie_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends Cubit<ProfileState> {
  ProfileViewModel() : super(ProfileLoading());
  void getProfileAndFavorites() async {
    var token = await LoginViewModel.getSavedToken();

    try {
      if (token == null) {
        emit(ProfileError(message: 'User is not logged in.'));
        return;
      }
      emit(ProfileLoading());
      UserModel user = await ApiManger.getProfile(token: token);
      List<FavoriteMovie> favorites =
          await ApiManger.getFavorites(token: token);

      emit(ProfileSuccess(user: user, favoritesMovies: favorites));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_token'); 
    emit(ProfileEmpty()); 
  }
}
