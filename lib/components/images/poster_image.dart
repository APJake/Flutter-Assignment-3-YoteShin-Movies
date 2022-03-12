import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../networks/api.dart';

class PosterImage extends StatelessWidget {
  final String imageUrl;
  const PosterImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: API.imageURL400 + (imageUrl),
      placeholder: (context, url) => const SizedBox(
        width: double.infinity,
        child: Image(
          image: AssetImage("assets/images/movie_poster_placeholder_low.jpg"),
        ),
      ),
      errorWidget: (context, url, error) => const SizedBox(
        width: double.infinity,
        child: Image(
          image: AssetImage("assets/images/movie_poster_error_low.jpg"),
        ),
      ),
    );
  }
}
