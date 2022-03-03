library pilar.movie_model;

import 'dart:convert';

class Tv {
  var id, original_title, vote_average, overview, poster_path;
  Tv(
      {this.id,
      this.original_title,
      this.vote_average,
      this.overview,
      this.poster_path});
  factory Tv.fromJson(Map<String, dynamic> json) {
    return Tv(
      id: json['id'],
      original_title: json['original_name'],
      vote_average: json['vote_average'],
      overview: json['overview'],
      poster_path: json['poster_path'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'original_name': original_title,
        'vote_average': vote_average,
        'overview': overview,
        'poster_path': poster_path,
      };
}

TvList tvListFromJson(String str) => TvList.fromJson(json.decode(str));

String tvListToJson(TvList data) => json.encode(data.toJson());

class TvList {
  final List<Tv> results;
  TvList({required this.results});
  factory TvList.fromJson(Map<String, dynamic> json) => TvList(
        results: List<Tv>.from(json["results"].map((x) => Tv.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
