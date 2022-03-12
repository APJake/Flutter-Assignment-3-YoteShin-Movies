// To parse this JSON data, do
//
//     final responseReviews = responseReviewsFromJson(jsonString);

import 'dart:convert';

import 'package:yoteshin_movies_asm/models/review.dart';

class ResponseReviews {
  ResponseReviews({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int id;
  int page;
  List<Review> results;
  int totalPages;
  int totalResults;

  factory ResponseReviews.fromRawJson(String str) =>
      ResponseReviews.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponseReviews.fromJson(Map<String, dynamic> json) =>
      ResponseReviews(
        id: json["id"],
        page: json["page"],
        results:
            List<Review>.from(json["results"].map((x) => Review.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
