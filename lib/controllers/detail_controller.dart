import 'package:get/get.dart';
import 'package:yoteshin_movies_asm/networks/api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/cast.dart';
import '../models/crew.dart';
import '../models/movie.dart';
import '../models/video.dart';

class DetailController extends GetxController {
  final API api = API();

  late YoutubePlayerController youtubeController;
  RxList<Cast> castList = <Cast>[].obs;
  RxList<Crew> crewList = <Crew>[].obs;
  RxList<Video> videoList = <Video>[].obs;
  RxList<Movie> recommendationMovies = <Movie>[].obs;
  RxList<Movie> similarMovies = <Movie>[].obs;

  initYoutubeController(key) {
    youtubeController = YoutubePlayerController(
      initialVideoId: key,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  loadCastList(id) {
    api.getCasts(id).then((value) {
      castList.value = value;
    });
  }

  loadVideoList(id) {
    api.getVideos(id).then((value) {
      initYoutubeController(value[0].key);
      videoList.value = value;
    });
  }

  loadCrewList(id) {
    api.getCrews(id).then((value) {
      crewList.value = value;
    });
  }

  loadRecommendationMovies(id) {
    api.getRecommendationMovies(id).then((value) {
      recommendationMovies.value = value;
    });
  }

  loadSimilarMovies(id) {
    api.getSimilarMovies(id).then((value) {
      similarMovies.value = value;
    });
  }
}
