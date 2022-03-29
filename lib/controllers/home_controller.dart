import 'package:get/get.dart';
import 'package:yoteshin_movies_asm/models/movie.dart';
import 'package:yoteshin_movies_asm/networks/api.dart';

class HomeController extends GetxController {
  // List<Movie>? popularMovies, nowPlayingMovies, upcomingMovies, trendingMovies;
  RxList<Movie> popularMovies = <Movie>[].obs;
  RxList<Movie> nowPlayingMovies = <Movie>[].obs;
  RxList<Movie> upcomingMovies = <Movie>[].obs;
  RxList<Movie> trendingMovies = <Movie>[].obs;
  RxBool isSigningOut = false.obs;
  final API api = API();

  void makeSigningOut() {
    isSigningOut = true.obs;
  }

  void loadPopularMovies() {
    api.getPopularMovies().then((value) {
      popularMovies.value = value;
    });
  }

  void loadNowPlayingMovies() {
    api.getNowPlayingMovies().then((value) {
      nowPlayingMovies.value = value;
    });
  }

  void loadUpcomingMovies() {
    api.getUpcomingMovies().then((value) {
      upcomingMovies.value = value;
    });
  }

  void loadTrendingMovies() {
    api.getTrendingMovies().then((value) {
      trendingMovies.value = value;
    });
  }
}
