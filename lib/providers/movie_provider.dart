// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'package:pilar/main.dart';
import 'package:http/http.dart' as http;
import 'package:pilar/models/movie_model.dart';

class MovieProviders extends ChangeNotifier {
  static MovieList? _listMovie;
  MovieList? get listMovie => _listMovie;
  Future<MovieList?> getListMovie() async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3' +
        '/movie/now_playing?api_key=' +
        'fbb9572d11b5458ac98f02b84f2bafc4'));
    print('getListMovie response: ${response.body}');
    _listMovie = movieListFromJson(response.body);
    print('getListMovie: ${_listMovie.runtimeType}');
    notifyListeners();
    return _listMovie;
  }
}
