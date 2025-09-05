import 'package:movie_app/models/user_model.dart';

abstract class RegisterState {}

class RegisterLoading extends RegisterState {}
class RegisterInti extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final UserModel user;

  RegisterSuccess( {required this.user});
}

class RegisterFailure extends RegisterState {
 final String message;
  RegisterFailure({required this.message});
}
