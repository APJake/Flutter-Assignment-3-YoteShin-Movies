import 'package:flutter/material.dart';
import 'package:yoteshin_movies_asm/models/movie_collection.dart';
import 'package:get/get.dart';

import '../../networks/api.dart';
import '../../pages/collection_page.dart';
import '../images/poster_image.dart';

class CollectionItem extends StatelessWidget {
  final MovieCollection collection;
  const CollectionItem({Key? key, required this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(CollectionPage(tag: "collection", collection: collection));
      },
      child: SizedBox(
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
                    tag: "collection${collection.id}",
                    child: PosterImage(
                        imageUrl: API.imageURL400 + collection.posterPath)),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                collection.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
