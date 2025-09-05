import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Api/api_manger.dart';
import 'package:movie_app/blocs/auth_cubit/register/resgister_state.dart';

class RegisterViewModel extends Cubit<RegisterState> {
  RegisterViewModel() : super(RegisterInti());
  int selectedAvatar = 0;

  void setAvatar(int index) {
    selectedAvatar = index;
  }

  void register(
      {required String name,
      required String email,
      required String password,
      required String confirmPassword,
      required String phone,
      required int avaterId}) async {
    try {
      emit(RegisterLoading());
      var response = await ApiManger.register(
          name: name,
          email: email,
          password: password,
          phone: phone,
          confirmPassword: confirmPassword,
          avaterId: avaterId
          );
      emit(RegisterSuccess(user: response));
    } catch (e) {
      emit(RegisterFailure(message: e.toString()));
    }
  }
}
