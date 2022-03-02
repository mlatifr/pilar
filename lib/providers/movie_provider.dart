// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'package:pilar/main.dart';
import 'package:http/http.dart' as http;

class MovieProviders extends ChangeNotifier {
  Future getListMovie() async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3' +
        '/movie/now_playing?api_key=' +
        'fbb9572d11b5458ac98f02b84f2bafc4'));
    print('response: ${response.body}');
  }
}
