import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Api/api_manger.dart';
import 'package:movie_app/blocs/auth_cubit/login/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends Cubit<LoginState> {
  LoginViewModel() : super(LoginInitial());

  void login({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoginLoading());
      var response = await ApiManger.login(email: email, password: password);
      
      emit(LoginSuccess(token: response));
    } catch (e) {
      
      emit(LoginFailure(message: e.toString()));
    }
  }

 static Future<String?> getSavedToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_token');
}
}
