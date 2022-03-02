// ignore: camel_case_types, must_be_immutable
import 'package:flutter/material.dart';
import 'package:pilar/models/movie_model.dart';

class widgetCardMovie extends StatelessWidget {
  var item;
  widgetCardMovie({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        height: 250,
        color: Colors.blue,
        child: Column(children: [
          if (item != null)
            Image.network(
              'https://image.tmdb.org/t/p/w500/${item?.poster_path}',
              width: 100,
              height: 200,
            ),
          if (item != null)
            Text(
              '${item?.original_title}',
              overflow: TextOverflow.ellipsis,
            ),
          if (item != null) Text('${item?.vote_average}'),
        ]),
      ),
    );
  }
}
