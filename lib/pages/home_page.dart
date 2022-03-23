import 'package:flutter/material.dart';
import 'package:yoteshin_movies_asm/components/lists/moive_list.dart';
import 'package:yoteshin_movies_asm/pages/search_page.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.loadTrendingMovies();
    controller.loadPopularMovies();
    controller.loadNowPlayingMovies();
    controller.loadUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("YoteShin Movies"),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(SearchPage());
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(children: [
              controller.trendingMovies.isEmpty
                  ? const CircularProgressIndicator()
                  : MovieList(
                      title: "Trending",
                      movieList: controller.trendingMovies,
                    ),
              controller.popularMovies.isEmpty
                  ? const CircularProgressIndicator()
                  : MovieList(
                      title: "Popular",
                      movieList: controller.popularMovies,
                    ),
              controller.nowPlayingMovies.isEmpty
                  ? const CircularProgressIndicator()
                  : MovieList(
                      title: "Now Playing",
                      movieList: controller.nowPlayingMovies,
                    ),
              controller.upcomingMovies.isEmpty
                  ? const CircularProgressIndicator()
                  : MovieList(
                      title: "Upcoming",
                      movieList: controller.upcomingMovies,
                    ),
            ]),
          ),
        ));
  }
}
