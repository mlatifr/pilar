library pilar.tv_model;

import 'dart:convert';

class TvHomePage {
  var id, original_title, vote_average, overview, poster_path, runtime;
  TvHomePage(
      {this.id,
      this.original_title,
      this.vote_average,
      this.overview,
      this.poster_path,
      this.runtime});
  factory TvHomePage.fromJson(Map<String, dynamic> json) {
    return TvHomePage(
        id: json['id'],
        original_title: json['original_name'],
        vote_average: json['vote_average'],
        overview: json['overview'],
        poster_path: json['poster_path'],
        runtime: json['runtime']);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'original_name': original_title,
        'vote_average': vote_average,
        'overview': overview,
        'poster_path': poster_path,
        'runtime': runtime
      };
}

class TvDetail {
  var id, original_title, vote_average, overview, poster_path, runtime;
  TvDetail(
      {this.id,
      this.original_title,
      this.vote_average,
      this.overview,
      this.poster_path,
      this.runtime});
  factory TvDetail.fromJson(Map<String, dynamic> json) {
    return TvDetail(
        id: json['id'],
        original_title: json['original_title'],
        vote_average: json['vote_average'],
        overview: json['overview'],
        poster_path: json['backdrop_path'],
        runtime: json['runtime']);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'original_title': original_title,
        'vote_average': vote_average,
        'overview': overview,
        'backdrop_path': poster_path,
        'runtime': runtime
      };
}

TvList tvListFromJson(String str) => TvList.fromJson(json.decode(str));
TvDetail tvDetailFromJson(String str) => TvDetail.fromJson(json.decode(str));
String tvListToJson(TvList data) => json.encode(data.toJson());

class TvList {
  final List<TvHomePage> results;
  TvList({required this.results});
  factory TvList.fromJson(Map<String, dynamic> json) => TvList(
        results: List<TvHomePage>.from(
            json["results"].map((x) => TvHomePage.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
