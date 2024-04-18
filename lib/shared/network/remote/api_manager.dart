import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/models/toprated_response.dart';

import '../../../models/categories_response.dart';
import '../../../models/popular_response.dart';
import '../../../models/search_response.dart';
import '../../../models/upcoming_response.dart';

class ApiManager {
  static Future<UpComingResponse> getUpcomingMovies() async {
    var url = Uri.https("api.themoviedb.org", "/3/movie/popular",
        {"api_key": "458af48ac7026cc7c22b8a04b3cddd30"});

    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var upcomingModel = UpComingResponse.fromJson(json);
    return upcomingModel;
  }

  static Future<PopularResponse> getPopularMovies() async {
    var url = Uri.https("api.themoviedb.org", "/3/movie/upcoming",
        {"api_key": "458af48ac7026cc7c22b8a04b3cddd30"});

    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var popularModel = PopularResponse.fromJson(json);
    return popularModel;
  }

  static Future<TopRatedResponse> getTopRatedMovies() async {
    var url = Uri.https("api.themoviedb.org", "/3/movie/top_rated",
        {"api_key": "458af48ac7026cc7c22b8a04b3cddd30"});

    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var topRatedModel = TopRatedResponse.fromJson(json);
    return topRatedModel;
  }

  static Future<CategoriesResponse> getCategories() async {
    var url = Uri.https("api.themoviedb.org", "/3/genre/movie/list",
        {"api_key": "458af48ac7026cc7c22b8a04b3cddd30"});

    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var categoriesModel = CategoriesResponse.fromJson(json);
    return categoriesModel;
  }

  static Future<SearchResponse> searchMovies(String query) async {
    var url = Uri.https("api.themoviedb.org", "/3/search/movie", {
      "api_key": "458af48ac7026cc7c22b8a04b3cddd30",
      "query": query,
    });

    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var searchModel = SearchResponse.fromJson(json);

    return searchModel;
  }
}
