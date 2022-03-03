library pilar.movie_model;

import 'dart:convert';

class Movie {
  var id, original_title, vote_average, overview, poster_path, runtime;
  Movie(
      {this.id,
      this.original_title,
      this.vote_average,
      this.overview,
      this.poster_path,
      this.runtime});
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        original_title: json['original_title'],
        vote_average: json['vote_average'],
        overview: json['overview'],
        poster_path: json['poster_path'],
        runtime: json['runtime']);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'original_title': original_title,
        'vote_average': vote_average,
        'overview': overview,
        'poster_path': poster_path,
        'runtime': runtime
      };
}

Movie movieDetailFromJson(String str) => Movie.fromJson(json.decode(str));
Movie tvDetailFromJson(String str) => Movie.fromJson(json.decode(str));

class MovieList {
  final List<Movie> results;
  MovieList({required this.results});
  factory MovieList.fromJson(Map<String, dynamic> json) => MovieList(
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

MovieList movieListFromJson(String str) => MovieList.fromJson(json.decode(str));

String movieListToJson(MovieList data) => json.encode(data.toJson());
