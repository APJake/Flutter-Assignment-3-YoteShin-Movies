// To parse this JSON data, do
//
//     final movieCollection = movieCollectionFromJson(jsonString);

import 'dart:convert';

class MovieCollection {
  MovieCollection({
    required this.id,
    required this.backdropPath,
    required this.name,
    required this.posterPath,
  });

  int id;
  String backdropPath;
  String name;
  String posterPath;

  factory MovieCollection.fromRawJson(String str) =>
      MovieCollection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieCollection.fromJson(Map<String, dynamic> json) =>
      MovieCollection(
        id: json["id"],
        backdropPath: json["backdrop_path"] ?? "",
        name: json["name"],
        posterPath: json["poster_path"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "backdrop_path": backdropPath,
        "name": name,
        "poster_path": posterPath,
      };
}
