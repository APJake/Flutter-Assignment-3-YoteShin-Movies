import 'package:get/get.dart';
import 'package:yoteshin_movies_asm/models/movie.dart';
import 'package:yoteshin_movies_asm/models/movie_collection.dart';

import '../networks/api.dart';

class SearchController extends GetxController {
  final API api = API();
  RxList<Movie> movieList = <Movie>[].obs;
  RxList<MovieCollection> collectionList = <MovieCollection>[].obs;
  RxBool isSearching = false.obs;
  RxBool didSearched = false.obs;

  searchMovie(query) {
    isSearching.value = true;
    didSearched.value = true;

    api.getSearchMovieCollections(query).then((value) {
      collectionList.value = value;
      isSearching.value = false;
    });
    api.getSearchMovies(query).then((value) {
      movieList.value = value;
      isSearching.value = false;
    });
  }
}
