import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yoteshin_movies_asm/components/images/poster_image.dart';
import 'package:yoteshin_movies_asm/components/lists/moive_list.dart';
import 'package:yoteshin_movies_asm/controllers/detail_controller.dart';
import 'package:yoteshin_movies_asm/helper/use_me.dart';
import 'package:yoteshin_movies_asm/models/cast.dart';
import 'package:yoteshin_movies_asm/models/crew.dart';
import 'package:yoteshin_movies_asm/models/movie.dart';
import 'package:yoteshin_movies_asm/models/video.dart';
import 'package:yoteshin_movies_asm/networks/api.dart';
import 'package:yoteshin_movies_asm/pages/reviews_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../components/images/cover_image.dart';
import '../components/items/cast_item.dart';

class DetailPage extends StatefulWidget {
  final Movie movie;
  final String tag;
  const DetailPage({Key? key, required this.tag, required this.movie})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final DetailController controller = DetailController();

  @override
  void initState() {
    controller.loadCastList(widget.movie.id);
    controller.loadCrewList(widget.movie.id);
    controller.loadVideoList(widget.movie.id);
    controller.loadSimilarMovies(widget.movie.id);
    controller.loadRecommendationMovies(widget.movie.id);
    super.initState();
  }

  Widget _coverImage() => SizedBox(
      width: double.infinity,
      height: 260,
      child: CoverImage(imageUrl: API.imageURL400 + widget.movie.backdropPath));

  Widget _castList() => controller.castList.isEmpty
      ? const CircularProgressIndicator()
      : SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 120,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.castList.length,
              itemBuilder: ((context, index) {
                Cast cast = controller.castList[index];
                return CastItem(
                  name: cast.name,
                  id: cast.id,
                  profilePath: cast.profilePath ?? "",
                );
              })),
        );

  Widget _crewList() => controller.crewList.isEmpty
      ? const CircularProgressIndicator()
      : SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 120,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.crewList.length,
              itemBuilder: ((context, index) {
                Crew crew = controller.crewList[index];
                return CastItem(
                  name: crew.name,
                  id: crew.id,
                  profilePath: crew.profilePath,
                );
              })),
        );
  Widget _title(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );

  Widget _movieHeader() => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 130,
            child: Card(
              elevation: 5,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Hero(
                  tag: "${widget.tag}${widget.movie.id}",
                  child: PosterImage(
                      imageUrl: API.imageURL400 + widget.movie.posterPath)),
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.movie.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text("★ ${widget.movie.voteAverage}"),
                const SizedBox(height: 5),
                Text(
                  UseMe.getPrettyDate(widget.movie.releaseDate),
                  style: const TextStyle(
                      fontSize: 12, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 18)
              ],
            ),
          )
        ],
      );

  Widget _movieInformation() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _movieHeader(),
          const SizedBox(
            height: 20,
          ),
          _title("Overview"),
          Text(widget.movie.overview),
        ],
      );

  Widget _youtubePlayer(Video video) {
    controller.initYoutubeController(video.key);
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller.youtubeController,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            video.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          player,
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget _readReviewsButton() => SizedBox(
        width: double.infinity,
        child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReviewsPage(
                            movie: widget.movie,
                          )));
            },
            child: const Text("READ REVIEWS")),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(widget.movie.title),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              _coverImage(),
              Container(
                margin: const EdgeInsets.only(top: 180),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _movieInformation(),
                        const SizedBox(height: 10),
                        _readReviewsButton(),
                        const SizedBox(height: 20),
                        controller.videoList.isNotEmpty
                            ? _youtubePlayer(
                                UseMe.getTrailerVideo(controller.videoList))
                            : Container(),
                        _title("Cast"),
                        _castList(),
                        _title("Crew"),
                        _crewList(),
                        controller.similarMovies.isEmpty
                            ? const CircularProgressIndicator()
                            : MovieList(
                                title: "Similar",
                                movieList: controller.similarMovies),
                        controller.recommendationMovies.isEmpty
                            ? const CircularProgressIndicator()
                            : MovieList(
                                title: "Recommendation",
                                movieList: controller.recommendationMovies),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
