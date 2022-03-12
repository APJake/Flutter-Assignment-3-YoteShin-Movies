// To parse this JSON data, do
//
//     final responseCollections = responseCollectionsFromJson(jsonString);

import 'dart:convert';

import 'package:yoteshin_movies_asm/models/movie_collection.dart';

class ResponseCollections {
  ResponseCollections({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<MovieCollection> results;
  int totalPages;
  int totalResults;

  factory ResponseCollections.fromRawJson(String str) =>
      ResponseCollections.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponseCollections.fromJson(Map<String, dynamic> json) =>
      ResponseCollections(
        page: json["page"],
        results: List<MovieCollection>.from(
            json["results"].map((x) => MovieCollection.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
