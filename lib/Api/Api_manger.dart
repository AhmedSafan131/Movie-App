import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/Api/api_constants.dart';
import 'package:movie_app/Api/end_point.dart';
import 'package:movie_app/models/movies_response.dart';

class ApiManger {
  static Future<MoviesResponse> getMoviesList() async {
    Uri url = Uri.https(ApiConstants.moveisBaseUrl, EndPoint.movieApi);
 
   
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MoviesResponse.fromJson(json);
    } catch (e) {
      //print(e);
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
}
