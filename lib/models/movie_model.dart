library pilar.movie_model;

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
}
