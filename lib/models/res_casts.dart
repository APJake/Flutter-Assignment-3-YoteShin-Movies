// To parse this JSON data, do
//
//     final responseCredits = responseCreditsFromJson(jsonString);

import 'dart:convert';

import 'package:yoteshin_movies_asm/models/cast.dart';
import 'package:yoteshin_movies_asm/models/crew.dart';

class ResponseCredits {
  ResponseCredits({
    required this.id,
    required this.cast,
    required this.crew,
  });

  int id;
  List<Cast> cast;
  List<Crew> crew;

  factory ResponseCredits.fromRawJson(String str) =>
      ResponseCredits.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponseCredits.fromJson(Map<String, dynamic> json) =>
      ResponseCredits(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
      };
}
