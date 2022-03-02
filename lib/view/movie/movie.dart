import 'package:flutter/material.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Pilar Movies')),
      ),
      body: SafeArea(
          child: Column(children: [
        Text('Movie'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [for (var i = 0; i < 10; i++) widgetPosterMovie()],
          ),
        ),
        Text('tv'),
        Row(
          children: [
            Text('tv'),
            Text('tv'),
            Text('tv'),
            Text('tv'),
          ],
        ),
      ])),
    );
  }
}

class widgetPosterMovie extends StatelessWidget {
  const widgetPosterMovie({
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
          Text('Judul'),
          Text('Rate'),
        ]),
      ),
    );
  }
}
