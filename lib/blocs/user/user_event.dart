import 'package:equatable/equatable.dart';
import '../../models/user_model.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoadUser extends UserEvent {
  const LoadUser();
}

class UpdateUser extends UserEvent {
  final UserModel user;

  const UpdateUser(this.user);

  @override
  List<Object?> get props => [user];
}

class UpdateUserName extends UserEvent {
  final String name;

  const UpdateUserName(this.name);

  @override
  List<Object?> get props => [name];
}

class UpdateUserPhone extends UserEvent {
  final String phone;

  const UpdateUserPhone(this.phone);

  @override
  List<Object?> get props => [phone];
}

class UpdateUserAvatar extends UserEvent {
  final String avatar;

  const UpdateUserAvatar(this.avatar);

  @override
  List<Object?> get props => [avatar];
}

class ClearUser extends UserEvent {
  const ClearUser();
}
