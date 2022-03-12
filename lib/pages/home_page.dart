import 'package:flutter/material.dart';
import 'package:yoteshin_movies_asm/components/lists/moive_list.dart';
import 'package:yoteshin_movies_asm/models/movie.dart';
import 'package:yoteshin_movies_asm/networks/api.dart';
import 'package:yoteshin_movies_asm/pages/search_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie>? popularMovies, nowPlayingMovies, upcomingMovies, trendingMovies;
  final API api = API();

  void loadPopularMovies() {
    api.getPopularMovies().then((value) {
      setState(() {
        popularMovies = value;
      });
    });
  }

  void loadNowPlayingMovies() {
    api.getNowPayingMovies().then((value) {
      setState(() {
        nowPlayingMovies = value;
      });
    });
  }

  void loadUpcomingMovies() {
    api.getUpcomingMovies().then((value) {
      setState(() {
        upcomingMovies = value;
      });
    });
  }

  void loadTrendingMovies() {
    api.getTrendingMovies().then((value) {
      setState(() {
        trendingMovies = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadTrendingMovies();
    loadPopularMovies();
    loadNowPlayingMovies();
    loadUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("YoteShin Movies"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          trendingMovies == null
              ? const CircularProgressIndicator()
              : MovieList(
                  title: "Trending",
                  movieList: trendingMovies!,
                ),
          popularMovies == null
              ? const CircularProgressIndicator()
              : MovieList(
                  title: "Popular",
                  movieList: popularMovies!,
                ),
          nowPlayingMovies == null
              ? const CircularProgressIndicator()
              : MovieList(
                  title: "Now Playing",
                  movieList: nowPlayingMovies!,
                ),
          upcomingMovies == null
              ? const CircularProgressIndicator()
              : MovieList(
                  title: "Upcoming",
                  movieList: upcomingMovies!,
                ),
        ]),
      ),
    );
  }
}
