import 'dart:ffi';

import 'package:get/get.dart';
import 'package:yoteshin_movies_asm/networks/api.dart';

import '../models/review.dart';

class ReviewsController extends GetxController {
  final API api = API();
  RxList<Review> reviewList = <Review>[].obs;
  RxBool isLoading = true.obs;

  loadReviews(movieId) {
    API().getReviews(movieId).then((value) {
      isLoading.value = false;
      reviewList.value = value;
    });
  }
}
