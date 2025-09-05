import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/Api/api_constants.dart';
import 'package:movie_app/Api/end_point.dart';
import 'package:movie_app/models/favorite_movie.dart';
import 'package:movie_app/models/movies_response.dart';
import 'package:movie_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiManger {
  static Future<MoviesResponse> getMoviesList() async {
    Uri url = Uri.https(ApiConstants.moveisBaseUrl, EndPoint.movieApi);

    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MoviesResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  static Future<MoviesResponse?> getMovieByName(String movieTitle) async {
    Uri url = Uri.https(ApiConstants.moveisBaseUrl, EndPoint.movieApi,
        {'query_term': movieTitle});
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MoviesResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) async {
    Uri url = Uri.https(ApiConstants.authBaseUrl, EndPoint.registerApi);
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'name': name,
            'email': email,
            'password': password,
            'confirmPassword': confirmPassword,
            'phone': phone,
            'avaterId': avaterId,
          }));

      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['data'] == null) {
        throw Exception("No 'data' field in response: $jsonResponse");
      }
      await login(email: email, password: password);
      return UserModel.fromJson(jsonResponse['data']);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> login({
    required String email,
    required String password,
  }) async {
    Uri url = Uri.https(ApiConstants.authBaseUrl, EndPoint.loginApi);
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}));

      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['data'] == null) {
        throw Exception("No 'data' field in response: $jsonResponse");
      }
      String token = jsonResponse['data'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_token', token);

      return token;
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserModel> getProfile({required String token}) async {
    Uri url = Uri.https(ApiConstants.authBaseUrl, EndPoint.profileApi);

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode != 200) {
        throw Exception("Failed to fetch profile: ${response.statusCode}");
      }

      final jsonResponse = jsonDecode(response.body);
    

      if (jsonResponse['data'] == null) {
        throw Exception("No 'data' field in response: $jsonResponse");
      }
      return UserModel.fromJson(jsonResponse['data']);
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<FavoriteMovie>> getFavorites(
      {required String token}) async {
    Uri url = Uri.https(ApiConstants.authBaseUrl, EndPoint.allFavoritesApi);
   
    try {
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode != 200) {
        throw Exception("Failed to fetch profile: ${response.statusCode}");
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['data'] == null || jsonResponse['data'] is! List) {
        throw Exception("No 'data' field in response: $jsonResponse");
      }
      final favorites = (jsonResponse['data'] as List)
          .map((item) => FavoriteMovie.fromJson(item))
          .toList();

      return favorites;
    } catch (e) {
      rethrow;
    }
  }
}
