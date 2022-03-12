// To parse this JSON data, do
//
//     final responseVideos = responseVideosFromJson(jsonString);

import 'dart:convert';

import 'package:yoteshin_movies_asm/models/video.dart';

class ResponseVideos {
  ResponseVideos({
    required this.id,
    required this.results,
  });

  int id;
  List<Video> results;

  factory ResponseVideos.fromRawJson(String str) =>
      ResponseVideos.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponseVideos.fromJson(Map<String, dynamic> json) => ResponseVideos(
        id: json["id"],
        results:
            List<Video>.from(json["results"].map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
