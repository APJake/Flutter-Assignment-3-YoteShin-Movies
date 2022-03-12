import 'package:flutter/material.dart';
import 'package:yoteshin_movies_asm/components/images/profile_image.dart';
import 'package:yoteshin_movies_asm/helper/use_me.dart';
import 'package:yoteshin_movies_asm/models/review.dart';

class ReviewItem extends StatelessWidget {
  final Review review;
  const ReviewItem({Key? key, required this.review}) : super(key: key);

  Widget _header() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 40,
              height: 40,
              child: ProfileImage(
                imageUrl: review.authorDetails.avatarPath.substring(1),
                errorIconSize: 40,
              )),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.author,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    UseMe.getPrettyDate(review.createdAt),
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget _horizontalLine() => Container(
        margin: const EdgeInsets.only(top: 10, left: 5),
        width: 180,
        height: 1,
        color: Colors.black12,
      );

  Widget _content() => Padding(
        padding: const EdgeInsets.only(
          top: 12,
        ),
        child: Text(review.content),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              _horizontalLine(),
              _content(),
            ],
          ),
        ),
      ),
    );
  }
}
