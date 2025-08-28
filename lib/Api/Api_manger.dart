import 'dart:convert';

import 'package:movie_app/Api/Api_constants.dart';
import 'package:movie_app/Api/end_point.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movies_response.dart';

class ApiManger {
  static Future<MoviesResponse> getMoviesList() async {
    Uri url = Uri.parse("https://yts.mx/api/v2/list_movies.json");
 
    // Uri url = Uri.https(
    //   ApiConstants.baseUrl,
    //   EndPoint.movieListApi,
    // );
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MoviesResponse.fromJson(json);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
