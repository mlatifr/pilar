library pilar.movie_model;

import 'dart:convert';

class Movie {
  var original_title, vote_average, overview, poster_path;
  Movie(
      {this.original_title,
      this.vote_average,
      this.overview,
      this.poster_path});
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      original_title: json['original_title'],
      vote_average: json['vote_average'],
      overview: json['overview'],
      poster_path: json['poster_path'],
    );
  }
  Map<String, dynamic> toJson() => {
        'original_title': original_title,
        'vote_average': vote_average,
        'overview': overview,
        'poster_path': poster_path,
      };
}

MovieList movieListFromJson(String str) => MovieList.fromJson(json.decode(str));

String movieListToJson(MovieList data) => json.encode(data.toJson());

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
