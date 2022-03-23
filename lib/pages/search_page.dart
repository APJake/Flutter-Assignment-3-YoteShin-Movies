import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yoteshin_movies_asm/components/items/collection_item.dart';
import 'package:yoteshin_movies_asm/controllers/search_controller.dart';
import 'package:yoteshin_movies_asm/models/movie.dart';
import 'package:yoteshin_movies_asm/models/movie_collection.dart';

import '../components/items/movie_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchController controller = SearchController();

  Widget _movieSearchList() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text("Movies")),
          Container(
            padding: const EdgeInsets.all(5.0),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.48,
                ),
                itemCount: controller.movieList.length,
                itemBuilder: (_, index) {
                  Movie movie = controller.movieList[index];
                  return MovieItem(tag: "search", movie: movie);
                }),
          ),
        ],
      );

  Widget _collectionSearchList() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text("Collections")),
          Container(
            padding: const EdgeInsets.all(5.0),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.52,
                ),
                itemCount: controller.collectionList.length,
                itemBuilder: (_, index) {
                  MovieCollection collection = controller.collectionList[index];
                  return CollectionItem(collection: collection);
                }),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: TextField(
          style: const TextStyle(color: Colors.white),
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            hintText: "Search",
          ),
          onSubmitted: (value) {
            controller.searchMovie(value);
          },
        )),
        body: Obx(
          () => SingleChildScrollView(
            child: !controller.didSearched.value
                ? const SizedBox(
                    height: 50, child: Center(child: Text("Search movies")))
                : Column(
                    children: [
                      const SizedBox(height: 20),
                      controller.collectionList.isEmpty
                          ? controller.isSearching.value
                              ? const Center(child: CircularProgressIndicator())
                              : Container()
                          : _collectionSearchList(),
                      controller.movieList.isEmpty
                          ? controller.isSearching.value
                              ? const Center(child: CircularProgressIndicator())
                              : Container()
                          : _movieSearchList(),
                    ],
                  ),
          ),
        ));
  }
}
