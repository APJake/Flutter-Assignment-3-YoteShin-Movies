import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yoteshin_movies_asm/components/images/poster_image.dart';
import 'package:yoteshin_movies_asm/components/lists/moive_list.dart';
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
  late YoutubePlayerController _controller;
  List<Cast>? castList;
  List<Crew>? crewList;
  List<Video>? videoList;
  List<Movie>? recommendationMovies, similarMovies;

  loadCastList() {
    API().getCasts(widget.movie.id).then((value) {
      setState(() {
        castList = value;
      });
    });
  }

  loadVideoList() {
    API().getVideos(widget.movie.id).then((value) {
      initController(value[0].key);
      setState(() {
        videoList = value;
      });
    });
  }

  loadCrewList() {
    API().getCrews(widget.movie.id).then((value) {
      setState(() {
        crewList = value;
      });
    });
  }

  loadRecommendationMovies() {
    API().getRecommendationMovies(widget.movie.id).then((value) {
      setState(() {
        recommendationMovies = value;
      });
    });
  }

  loadSimilarMovies() {
    API().getSimilarMovies(widget.movie.id).then((value) {
      setState(() {
        similarMovies = value;
      });
    });
  }

  initController(key) {
    _controller = YoutubePlayerController(
      initialVideoId: key,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void initState() {
    loadCastList();
    loadCrewList();
    loadVideoList();
    loadSimilarMovies();
    loadRecommendationMovies();
    super.initState();
  }

  Widget _coverImage() => SizedBox(
      width: double.infinity,
      height: 260,
      child: CoverImage(imageUrl: API.imageURL400 + widget.movie.backdropPath));

  Widget _castList() => castList == null
      ? const CircularProgressIndicator()
      : SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 120,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: castList!.length,
              itemBuilder: ((context, index) {
                Cast cast = castList![index];
                return CastItem(
                  name: cast.name,
                  id: cast.id,
                  profilePath: cast.profilePath ?? "",
                );
              })),
        );

  Widget _crewList() => crewList == null
      ? const CircularProgressIndicator()
      : SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 120,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: crewList!.length,
              itemBuilder: ((context, index) {
                Crew crew = crewList![index];
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
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _movieInformation(),
                      const SizedBox(height: 10),
                      _readReviewsButton(),
                      const SizedBox(height: 20),
                      videoList != null && videoList!.isNotEmpty
                          ? _youtubePlayer(UseMe.getTrailerVideo(videoList!))
                          : Container(),
                      _title("Cast"),
                      _castList(),
                      _title("Crew"),
                      _crewList(),
                      similarMovies == null
                          ? const CircularProgressIndicator()
                          : MovieList(
                              title: "Similar", movieList: similarMovies!),
                      recommendationMovies == null
                          ? const CircularProgressIndicator()
                          : MovieList(
                              title: "Recommendation",
                              movieList: recommendationMovies!),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
