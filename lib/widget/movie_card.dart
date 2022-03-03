// ignore: camel_case_types, must_be_immutable
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pilar/models/movie_model.dart';
import 'package:pilar/providers/movie_provider.dart';
import 'package:pilar/view/movie/detailmovie.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class widgetCardMovie extends StatefulWidget {
  var detailMovie; //for make sure we want to get detail movie

  var detailTv; //for make sure we want to get detail tv
  // ignore: prefer_typing_uninitialized_variables
  var item;
  widgetCardMovie({Key? key, this.item, this.detailMovie, this.detailTv})
      : super(key: key);

  @override
  State<widgetCardMovie> createState() => _widgetCardMovieState();
}

class _widgetCardMovieState extends State<widgetCardMovie> {
  var _onloading = true;
  @override
  void initState() {
    _onloading = true;
    widget.detailMovie = false;
    widget.detailTv = false;
    super.initState();
  }

  late Movie dataDetail = Movie();
  BuildContext? dialogContext;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //get detail movie before navigate to detail movie page
        Future _getDetailMovie(idMovie) async {
          await Provider.of<MovieProviders>(context, listen: false)
              .getDetailMovie(idMovie);
          dataDetail =
              Provider.of<MovieProviders>(context, listen: false).detailMovie!;
        }

        if (widget.detailMovie) {
          _getDetailMovie(widget.item.id).then((value) => {
                print('_getDetailMovie'),
                _onloading = false,
                if (_onloading == false) Navigator.pop(dialogContext!),
                if (_onloading == false) _onloading = true,
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => DetailMovie(
                      dataDetail: dataDetail,
                    ),
                  ),
                )
              });
        }
        if (_onloading == true) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              dialogContext = context;
              return AlertDialog(
                // title: Text("My title"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(),
                    Text("Loading..."),
                  ],
                ),
              );
            },
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 150,
          height: 250,
          color: Colors.blue,
          child: Column(children: [
            if (widget.item != null)
              Image.network(
                'https://image.tmdb.org/t/p/w500/${widget.item?.poster_path}',
                width: 100,
                height: 200,
              ),
            if (widget.item != null)
              Text(
                '${widget.item?.original_title}',
                overflow: TextOverflow.ellipsis,
              ),
            if (widget.item != null) Text('${widget.item?.vote_average}'),
          ]),
        ),
      ),
    );
  }
}
