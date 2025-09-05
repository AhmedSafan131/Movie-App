import 'package:movie_app/models/movies_response.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final int avatarId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Movies> favorites;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarId,
    this.createdAt,
    this.updatedAt,
    this.favorites = const [],
  });

  // إنشاء User من JSON
  factory UserModel.fromJson(Map<String, dynamic> json, {String? token}) {
    List<Movies> favs = [];
    if (json['favorites'] != null) {
      favs =
          List<Movies>.from(json['favorites'].map((x) => Movies.fromJson(x)));
    }

    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      avatarId: int.tryParse(json['avaterId'].toString()) ?? 0, 
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      favorites: favs,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatarId': avatarId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'favorites': favorites.map((x) => x.toJson()).toList(),
    };
  }
}
