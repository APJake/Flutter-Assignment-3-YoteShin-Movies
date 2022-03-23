// To parse this JSON data, do
//
//     final collectionDetail = collectionDetailFromJson(jsonString);

import 'dart:convert';

import 'package:yoteshin_movies_asm/models/movie.dart';

class CollectionDetail {
  CollectionDetail({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.parts,
  });

  int id;
  String name;
  String overview;
  String posterPath;
  String backdropPath;
  List<Movie> parts;

  factory CollectionDetail.fromRawJson(String str) =>
      CollectionDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CollectionDetail.fromJson(Map<String, dynamic> json) =>
      CollectionDetail(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        backdropPath: json["backdrop_path"] ?? "",
        parts: List<Movie>.from(json["parts"].map((x) => Movie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "backdrop_path": backdropPath,
        "parts": List<dynamic>.from(parts.map((x) => x.toJson())),
      };
}
