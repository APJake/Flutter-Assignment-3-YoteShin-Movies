import 'package:http/http.dart' as http;
import 'package:yoteshin_movies_asm/models/cast.dart';
import 'package:yoteshin_movies_asm/models/collection_detail.dart';
import 'package:yoteshin_movies_asm/models/crew.dart';

import 'package:yoteshin_movies_asm/models/movie.dart';
import 'package:yoteshin_movies_asm/models/movie_collection.dart';
import 'package:yoteshin_movies_asm/models/res_casts.dart';
import 'package:yoteshin_movies_asm/models/res_collections.dart';
import 'package:yoteshin_movies_asm/models/res_movies.dart';
import 'package:yoteshin_movies_asm/models/res_reviews.dart';
import 'package:yoteshin_movies_asm/models/res_videos.dart';
import 'package:yoteshin_movies_asm/models/review.dart';
import 'package:yoteshin_movies_asm/models/video.dart';

class API {
  static const String imageURL200 = "https://image.tmdb.org/t/p/w200";
  static const String imageURL400 = "https://image.tmdb.org/t/p/w400";

  final String _baseURL = "https://api.themoviedb.org/3";
  final String _apiKey = "c1344f49636138e12c007ee2cf3e7393";

  Future<http.Response> _doGet(String path, {String param = ""}) async {
    return http.get(Uri.parse("$_baseURL$path?api_key=$_apiKey&$param"));
  }

  Future<List<Movie>> _getMovieList(String path, {String param = ""}) async {
    final response = await _doGet(path, param: param);
    if (response.statusCode == 200) {
      var res = ResponseMovies.fromRawJson(response.body);
      return res.results;
    }
    throw Exception("Faild to load movies");
  }

  Future<List<Movie>> getPopularMovies() {
    return _getMovieList("/movie/popular");
  }

  Future<List<Movie>> getTrendingMovies() {
    return _getMovieList("/trending/movie/week");
  }

  Future<List<Movie>> getNowPayingMovies() {
    return _getMovieList("/movie/now_playing");
  }

  Future<List<Movie>> getUpcomingMovies() {
    return _getMovieList("/movie/upcoming");
  }

  Future<List<Movie>> getRecommendationMovies(int id) {
    return _getMovieList("/movie/$id/recommendations");
  }

  Future<List<Movie>> getSearchMovies(String query) {
    return _getMovieList("/search/movie", param: "query=$query");
  }

  Future<List<Movie>> getSimilarMovies(int id) {
    return _getMovieList("/movie/$id/similar");
  }

  Future<List<Cast>> getCasts(int id) async {
    final response = await _doGet("/movie/$id/credits");
    if (response.statusCode == 200) {
      var res = ResponseCredits.fromRawJson(response.body);
      return res.cast;
    }
    throw Exception("Faild to load credits");
  }

  Future<List<Crew>> getCrews(int id) async {
    final response = await _doGet("/movie/$id/credits");
    if (response.statusCode == 200) {
      var res = ResponseCredits.fromRawJson(response.body);
      return res.crew;
    }
    throw Exception("Faild to load credits");
  }

  Future<List<Video>> getVideos(int id) async {
    final response = await _doGet("/movie/$id/videos");
    if (response.statusCode == 200) {
      var res = ResponseVideos.fromRawJson(response.body);
      return res.results;
    }
    throw Exception("Faild to load credits");
  }

  Future<List<Review>> getReviews(int id) async {
    final response = await _doGet("/movie/$id/reviews");
    if (response.statusCode == 200) {
      var res = ResponseReviews.fromRawJson(response.body);
      return res.results;
    }
    throw Exception("Faild to load credits");
  }

  Future<List<MovieCollection>> getSearchMovieCollections(String query) async {
    final response = await _doGet("/search/collection", param: "query=$query");
    if (response.statusCode == 200) {
      var res = ResponseCollections.fromRawJson(response.body);
      return res.results;
    }
    throw Exception("Faild to load credits");
  }

  Future<CollectionDetail> getCollectionDetail(int id) async {
    final response = await _doGet("/collection/$id");
    if (response.statusCode == 200) {
      var res = CollectionDetail.fromRawJson(response.body);
      return res;
    }
    throw Exception(response.statusCode);
  }
}
