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
    await Provider.of<MovieProviders>(context, listen: false).getListMovie();
  }

  @override
  void initState() {
    _getListMovie();
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
            return SafeArea(
                child: ListView(children: [
              // if (movieList != null)
              //   for (var item in movieList.results)
              //     Text('${item.original_title}'),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Movie'),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (movieList != null)
                      for (var item in movieList.results)
                        widgetCardMovie(
                          item: item,
                        )
                    // for (var i = 0; i < 10; i++) widgetCardMovie()
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
                  children: [for (var i = 0; i < 10; i++) widgetCardMovie()],
                ),
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       _getListMovie();
              //     },
              //     child: Text('button'))
            ]));
          }),
    );
  }
}
