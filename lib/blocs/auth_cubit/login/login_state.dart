
abstract class LoginState {}

class LoginLoading extends LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final String token ;

  LoginSuccess( {required this.token});
}

class LoginFailure extends LoginState {
 final String message;
  LoginFailure({required this.message});
}
