import 'package:flutter/material.dart';
import 'package:yoteshin_movies_asm/components/images/poster_image.dart';
import 'package:yoteshin_movies_asm/components/images/profile_image.dart';
import 'package:yoteshin_movies_asm/components/items/movie_item.dart';
import 'package:yoteshin_movies_asm/models/movie.dart';

class SearchList extends StatefulWidget {
  final List<Movie> movieList;
  const SearchList({Key? key, required this.movieList}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 0.51,
          ),
          itemCount: widget.movieList.length,
          itemBuilder: (_, index) {
            Movie movie = widget.movieList[index];
            return MovieItem(tag: "search", movie: movie);
          }),
    );
  }
}
