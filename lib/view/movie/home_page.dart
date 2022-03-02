import 'package:flutter/material.dart';
import 'package:pilar/models/movie_model.dart';
import 'package:pilar/providers/movie_provider.dart';
import 'package:pilar/widget/movie_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _getListMovie() async {
    print('_getListMovie: homepage');
    await Provider.of<MovieProviders>(context, listen: false).getListMovie();
  }

  Future<void> _getListTv() async {
    print('_getListTv: homepage');
    await Provider.of<MovieProviders>(context, listen: false).getListTv();
  }

  @override
  void initState() {
    _getListMovie();
    _getListTv();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Pilar Movies')),
      ),
      body: AnimatedBuilder(
          animation: MovieProviders(),
          builder: (_, snapshot) {
            final provider = Provider.of<MovieProviders>(context);
            final movieList = provider.listMovie;
            final tvList = provider.listTv;
            return SafeArea(
                child: ListView(children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Movie'),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (movieList == null)
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (movieList != null)
                      for (var item in movieList.results)
                        widgetCardMovie(
                          item: item,
                        )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('tv'),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (tvList == null)
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (tvList != null)
                      for (var item in tvList.results)
                        widgetCardMovie(
                          item: item,
                        )
                  ],
                ),
              ),
            ]));
          }),
    );
  }
}
