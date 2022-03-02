// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:pilar/models/movie_model.dart';
import 'package:pilar/models/tv_model.dart';

class MovieProviders extends ChangeNotifier {
  //get list movie
  static MovieList? _listMovie;
  MovieList? get listMovie => _listMovie;
  Future<MovieList?> getListMovie() async {
    print('_getListMovie: provider');
    // ignore: prefer_adjacent_string_concatenation
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3' +
        '/movie/now_playing?api_key=' +
        'fbb9572d11b5458ac98f02b84f2bafc4'));
    _listMovie = movieListFromJson(response.body);
    notifyListeners();
    return _listMovie;
  }

  //get list tv
  static TvList? _listTv;
  TvList? get listTv => _listTv;
  Future<TvList?> getListTv() async {
    print('getListTv: provider');
    // ignore: prefer_adjacent_string_concatenation
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3' +
        '/tv/on_the_air?api_key=' +
        'fbb9572d11b5458ac98f02b84f2bafc4'));
    _listTv = tvListFromJson(response.body);
    notifyListeners();
    return _listTv;
  }

  //get detail movie
  static Movie? _detailMovie;
  Movie? get detailMovie => _detailMovie;
  Future<Movie?> getDetailMovie(idMovie) async {
    print('getDetailMovie: provider');
    // ignore: prefer_adjacent_string_concatenation
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3' +
        '/movie/$idMovie?api_key=' +
        'fbb9572d11b5458ac98f02b84f2bafc4'));
    print(response.body);
    _detailMovie = movieDetailFromJson(response.body);
    print('_detailMovie: ${_detailMovie?.original_title}');
    notifyListeners();
    return _detailMovie;
  }
}
