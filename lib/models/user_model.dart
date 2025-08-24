import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String phone;
  final String avatar;
  final String? email;

  const UserModel({
    required this.name,
    required this.phone,
    required this.avatar,
    this.email,
  });

  // Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      avatar: json['avatar'] ?? '',
      email: json['email'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'avatar': avatar,
      if (email != null) 'email': email,
    };
  }

  // Create a copy with updated fields
  UserModel copyWith({
    String? name,
    String? phone,
    String? avatar,
    String? email,
  }) {
    return UserModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
    );
  }

  // Create default user
  factory UserModel.defaultUser() {
    return const UserModel(
      name: 'User',
      phone: '',
      avatar: 'assets/images/avatar1.png',
    );
  }

  @override
  List<Object?> get props => [name, phone, avatar, email];

  @override
  String toString() {
    return 'UserModel(name: $name, phone: $phone, avatar: $avatar, email: $email)';
  }
}
