import 'package:flutter/material.dart';
import 'package:yoteshin_movies_asm/models/review.dart';

import '../items/review_item.dart';

class ReviewList extends StatefulWidget {
  final List<Review> reviewList;
  const ReviewList({Key? key, required this.reviewList}) : super(key: key);

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: widget.reviewList.length,
        itemBuilder: ((context, index) {
          Review review = widget.reviewList[index];
          return ReviewItem(review: review);
        }));
  }
}
