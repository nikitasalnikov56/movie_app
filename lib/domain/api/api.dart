import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie/domain/json_convertors/movies.dart';
import 'package:movie/domain/json_convertors/popular.dart';
import 'package:movie/domain/json_convertors/search_movie.dart';

//https://www.omdbapi.com/?s=avatar&apikey=f4e0873a

class Api {
//https://api.themoviedb.org/3/movie/top_rated?api_key=72ddeb361bcf40a3fddf08be5a9035d4&language=en-US&page=1

  static const String scheme = 'https';
  static const String host = 'api.themoviedb.org';

  static final String apiKey = dotenv.get('API_KEY');

  static Future<Movies> getMovies({var pageNum, String lang = 'ru'}) async {
    const String path = '3/movie/top_rated';
    Uri url = Uri(
      scheme: scheme,
      host: host,
      path: path,
      queryParameters: {
        'api_key': apiKey,
        'language': lang,
        'page': pageNum,
      },
    );
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Movies.fromJson(json);
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  static Future<Popular> getPopular({var pageNum, String lang = 'ru'}) async {
    const path = '3/movie/popular';
    Uri url = Uri(scheme: scheme, host: host, path: path, queryParameters: {
      'api_key': apiKey,
      'language': lang,
      'page': pageNum,
    });
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Popular.fromJson(json);
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  static Future<SearchMovie> searchMovie({String? movie = 'Avatar'}) async {
    // https://www.omdbapi.com/?s=avatar&apikey=f4e0873a
    const host = 'www.omdbapi.com';
    const apiKey = 'f4e0873a';

    Uri url = Uri(
      scheme: scheme,
      host: host,
      queryParameters: {
        's': movie,
        'apikey': apiKey,
      },
    );

    final response = await http.get(url);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return SearchMovie.fromJson(json);
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}
