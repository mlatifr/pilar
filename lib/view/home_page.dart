import 'package:flutter/material.dart';
import 'package:pilar/providers/movie_provider.dart';
import 'package:pilar/widget/movie_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var loadingPercentageMovie = 'Loading';
  var loadingPercentageTv = 'Loading';

  Future<void> _getListMovie() async {
    print('_getListMovie: homepage');
    await Provider.of<MovieProviders>(context, listen: false)
        .getListMovie()
        .then((value) {
      setState(() {
        loadingPercentageMovie = 'done';
      });
    });
  }

  Future<void> _getListTv() async {
    print('_getListTv: homepage');
    await Provider.of<MovieProviders>(context, listen: false)
        .getListTv()
        .then((value) {
      setState(() {
        loadingPercentageTv = 'done';
      });
    });
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
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Movie'),
                ),
              ),
              if (movieList == null || loadingPercentageMovie == 'Loading')
                Center(
                  child: Column(
                    children: [
                      const CircularProgressIndicator(),
                      Text('$loadingPercentageMovie')
                    ],
                  ),
                ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (movieList != null)
                      for (var item in movieList.results)
                        widgetCardMovie(item: item, detail: 'movie')
                  ],
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('TV'),
                ),
              ),
              if (tvList == null || loadingPercentageTv == 'Loading')
                Center(
                  child: Column(
                    children: [
                      const CircularProgressIndicator(),
                      Text('$loadingPercentageTv')
                    ],
                  ),
                ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (tvList != null)
                      for (var item in tvList.results)
                        widgetCardMovie(item: item, detail: 'tv')
                  ],
                ),
              ),
            ]));
          }),
    );
  }
}
