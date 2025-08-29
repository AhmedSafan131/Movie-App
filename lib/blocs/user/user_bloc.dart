import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model.dart';
import '../../repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({required UserRepository userRepository})
    : _userRepository = userRepository,
      super(const UserInitial()) {
    on<LoadUser>(_onLoadUser);
    on<UpdateUser>(_onUpdateUser);
    on<UpdateUserName>(_onUpdateUserName);
    on<UpdateUserPhone>(_onUpdateUserPhone);
    on<UpdateUserAvatar>(_onUpdateUserAvatar);
    on<ClearUser>(_onClearUser);
  }

  Future<void> _onLoadUser(LoadUser event, Emitter<UserState> emit) async {
    //print('=== BLoC: Loading User ===');
    emit(const UserLoading());
    try {
      final user = await _userRepository.loadUser();
      if (user != null) {
       // print('BLoC: User loaded successfully: $user');
        emit(UserLoaded(user));
      } else {
       // print('BLoC: No user found, creating default user...');
        // If no user data found, create default user
        final defaultUser = UserModel.defaultUser();
        await _userRepository.saveUser(defaultUser);
        //print('BLoC: Default user created and saved: $defaultUser');
        emit(UserLoaded(defaultUser));
      }
    } catch (e) {
      //('BLoC: Error loading user: $e');
      emit(UserError('Failed to load user: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    //('=== BLoC: Updating User ===');
    //print('BLoC: Updating user: ${event.user}');
    try {
      await _userRepository.saveUser(event.user);
//print('BLoC: User updated successfully');
      emit(UserLoaded(event.user));
    } catch (e) {
      //print('BLoC: Error updating user: $e');
      emit(UserError('Failed to update user: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateUserName(
    UpdateUserName event,
    Emitter<UserState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is UserLoaded) {
        final updatedUser = currentState.user.copyWith(name: event.name);
        await _userRepository.saveUser(updatedUser);
        emit(UserLoaded(updatedUser));
      }
    } catch (e) {
      emit(UserError('Failed to update user name: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateUserPhone(
    UpdateUserPhone event,
    Emitter<UserState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is UserLoaded) {
        final updatedUser = currentState.user.copyWith(phone: event.phone);
        await _userRepository.saveUser(updatedUser);
        emit(UserLoaded(updatedUser));
      }
    } catch (e) {
      emit(UserError('Failed to update user phone: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateUserAvatar(
    UpdateUserAvatar event,
    Emitter<UserState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is UserLoaded) {
        final updatedUser = currentState.user.copyWith(avatar: event.avatar);
        await _userRepository.saveUser(updatedUser);
        emit(UserLoaded(updatedUser));
      }
    } catch (e) {
      emit(UserError('Failed to update user avatar: ${e.toString()}'));
    }
  }

  Future<void> _onClearUser(ClearUser event, Emitter<UserState> emit) async {
    try {
      await _userRepository.clearUser();
      emit(const UserInitial());
    } catch (e) {
      emit(UserError('Failed to clear user: ${e.toString()}'));
    }
  }
}
