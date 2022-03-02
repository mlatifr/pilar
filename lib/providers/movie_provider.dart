// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:pilar/models/movie_model.dart';

class MovieProviders extends ChangeNotifier {
  static MovieList? _listMovie;
  MovieList? get listMovie => _listMovie;
  Future<MovieList?> getListMovie() async {
    // ignore: prefer_adjacent_string_concatenation
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3' +
        '/movie/now_playing?api_key=' +
        'fbb9572d11b5458ac98f02b84f2bafc4'));
    _listMovie = movieListFromJson(response.body);
    notifyListeners();
    return _listMovie;
  }
}
