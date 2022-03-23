import 'package:flutter/material.dart';
import 'package:yoteshin_movies_asm/models/movie.dart';
import 'package:yoteshin_movies_asm/networks/api.dart';
import 'package:yoteshin_movies_asm/pages/detail_page.dart';
import 'package:get/get.dart';

import '../images/poster_image.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  final String tag;
  final double width;
  const MovieItem(
      {Key? key, required this.tag, required this.movie, this.width = 130})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(DetailPage(tag: tag, movie: movie));
      },
      child: SizedBox(
        width: width,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children: [
              SizedBox(
                child: Hero(
                    tag: "$tag${movie.id}",
                    child: PosterImage(
                        imageUrl: API.imageURL400 + movie.posterPath)),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10, top: 3),
                width: double.infinity,
                child: Text(
                  "★ ${movie.voteAverage}",
                  textAlign: TextAlign.end,
                  style:
                      const TextStyle(color: Colors.deepOrange, fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
