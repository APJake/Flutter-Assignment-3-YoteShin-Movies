import 'package:flutter/material.dart';
import 'package:yoteshin_movies_asm/components/items/collection_item.dart';
import 'package:yoteshin_movies_asm/components/lists/search_list.dart';
import 'package:yoteshin_movies_asm/models/movie.dart';
import 'package:yoteshin_movies_asm/models/movie_collection.dart';
import 'package:yoteshin_movies_asm/networks/api.dart';

import '../components/items/movie_item.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Movie>? movieList;
  List<MovieCollection>? collectionList;
  bool isSearching = false;
  bool didSearched = false;
  API api = API();

  searchMovie(query) {
    setState(() {
      isSearching = true;
      didSearched = true;
    });
    api.getSearchMovieCollections(query).then((value) {
      setState(() {
        collectionList = value;
        isSearching = false;
      });
    });
    api.getSearchMovies(query).then((value) {
      setState(() {
        movieList = value;
        isSearching = false;
      });
    });
  }

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
                itemCount: movieList!.length,
                itemBuilder: (_, index) {
                  Movie movie = movieList![index];
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
                itemCount: collectionList!.length,
                itemBuilder: (_, index) {
                  MovieCollection collection = collectionList![index];
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
            searchMovie(value);
          },
        )),
        body: SingleChildScrollView(
          child: !didSearched
              ? const SizedBox(
                  height: 50, child: Center(child: Text("Search movies")))
              : Column(
                  children: [
                    const SizedBox(height: 20),
                    collectionList == null
                        ? isSearching
                            ? const Center(child: CircularProgressIndicator())
                            : Container()
                        : _collectionSearchList(),
                    movieList == null
                        ? isSearching
                            ? const Center(child: CircularProgressIndicator())
                            : Container()
                        : _movieSearchList(),
                  ],
                ),
        ));
  }
}
