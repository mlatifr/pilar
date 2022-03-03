import 'package:flutter/material.dart';
import 'package:pilar/models/movie_model.dart';

class DetailMovie extends StatefulWidget {
  Movie? dataDetail;
  DetailMovie({Key? key, this.dataDetail}) : super(key: key);

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
            alignment: Alignment.center,
            child: Text('${widget.dataDetail?.original_title}')),
      ),
      body: Stack(children: [
        Positioned(
          bottom: 50,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              'https://image.tmdb.org/t/p/w500/${widget.dataDetail?.poster_path}',
            ),
          ),
        ),
        //detail movie widget
        Positioned(
            top: MediaQuery.of(context).size.height / 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blue.withOpacity(0.85),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child:
                            Text('Rating: ${widget.dataDetail?.vote_average}'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${widget.dataDetail?.original_title}'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Genre'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Genre'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Genre'),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                                'Duration: ${widget.dataDetail?.runtime} Minutes'),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          '${widget.dataDetail?.overview}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )),
            )),
      ]),
    );
  }
}
