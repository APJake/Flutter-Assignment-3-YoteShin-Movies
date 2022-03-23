import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoteshin_movies_asm/components/images/poster_image.dart';
import 'package:yoteshin_movies_asm/components/lists/moive_list.dart';
import 'package:yoteshin_movies_asm/controllers/collection_controller.dart';
import 'package:yoteshin_movies_asm/models/movie_collection.dart';

import '../components/images/cover_image.dart';
import '../networks/api.dart';

class CollectionPage extends StatefulWidget {
  final String tag;
  final MovieCollection collection;
  const CollectionPage({Key? key, required this.tag, required this.collection})
      : super(key: key);

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  final CollectionController controller = CollectionController();

  @override
  void initState() {
    controller.loadCollectionDetail(widget.collection.id);
    super.initState();
  }

  Widget _collectionHeader() => Row(
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
                  tag: "${widget.tag}${widget.collection.id}",
                  child: PosterImage(
                      imageUrl:
                          API.imageURL400 + widget.collection.posterPath)),
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.collection.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                controller.detail.value == null
                    ? _loadingProgress()
                    : Text(
                        "Total: ${controller.detail.value!.parts.length}",
                        style: const TextStyle(
                            fontSize: 12, fontStyle: FontStyle.italic),
                      ),
                const SizedBox(height: 18)
              ],
            ),
          )
        ],
      );
  Widget _coverImage() => SizedBox(
        width: double.infinity,
        height: 260,
        child: CoverImage(
            imageUrl: API.imageURL400 + widget.collection.backdropPath),
      );

  Widget _loadingProgress() =>
      const SizedBox(width: 16, height: 16, child: CircularProgressIndicator());

  Widget _title(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.collection.name),
        elevation: 0,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Stack(
            children: [
              _coverImage(),
              Container(
                margin: const EdgeInsets.only(top: 160),
                width: double.infinity,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _collectionHeader(),
                    const SizedBox(height: 10),
                    _title("Overview"),
                    controller.detail.value == null
                        ? _loadingProgress()
                        : Text(controller.detail.value!.overview),
                    const SizedBox(height: 10),
                    controller.detail.value == null
                        ? _loadingProgress()
                        : MovieList(
                            title: "Movies",
                            movieList: controller.detail.value!.parts,
                            height: 330,
                            width: 180,
                          ),
                    const SizedBox(height: 50),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
