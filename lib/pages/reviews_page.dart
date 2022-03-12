import 'package:flutter/material.dart';
import 'package:yoteshin_movies_asm/components/lists/review_list.dart';
import 'package:yoteshin_movies_asm/helper/use_me.dart';
import 'package:yoteshin_movies_asm/models/movie.dart';
import 'package:yoteshin_movies_asm/models/review.dart';
import 'package:yoteshin_movies_asm/networks/api.dart';

import '../components/images/poster_image.dart';

class ReviewsPage extends StatefulWidget {
  final Movie movie;
  const ReviewsPage({Key? key, required this.movie}) : super(key: key);

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  List<Review>? reviewList;

  loadReviews() {
    API().getReviews(widget.movie.id).then((value) {
      setState(() {
        reviewList = value;
      });
    });
  }

  @override
  void initState() {
    loadReviews();
    super.initState();
  }

  Widget _movieProfile() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            width: 90,
            child: Card(
              elevation: 5,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: PosterImage(imageUrl: widget.movie.posterPath),
            ),
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  widget.movie.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
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
              ],
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews - ${widget.movie.title}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            _movieProfile(),
            const SizedBox(height: 20),
            reviewList == null
                ? const Center(child: CircularProgressIndicator())
                : reviewList!.isEmpty
                    ? const Center(child: Text("No reviews"))
                    : ReviewList(reviewList: reviewList!),
          ],
        ),
      ),
    );
  }
}
