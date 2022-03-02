import 'package:flutter/material.dart';
import 'package:pilar/providers/movie_provider.dart';
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
                child: Column(children: [
              if (movieList != null)
                for (var item in movieList.results)
                  Text('${item.original_title}'),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Movie'),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var i = 0; i < 10; i++) const widgetCardMovie()
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
                    for (var i = 0; i < 10; i++) const widgetCardMovie()
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    _getListMovie();
                  },
                  child: Text('button'))
            ]));
          }),
    );
  }
}

// ignore: camel_case_types
class widgetCardMovie extends StatelessWidget {
  const widgetCardMovie({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        height: 250,
        color: Colors.blue,
        child: Column(children: [
          Image.network(
            'https://image.tmdb.org/t/p/w500/w2PMyoyLU22YvrGK3smVM9fW1jj.jpg',
            width: 100,
            height: 200,
          ),
          const Text('Judul'),
          const Text('Rate'),
        ]),
      ),
    );
  }
}
