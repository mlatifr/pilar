import 'package:flutter/material.dart';
import 'package:pilar/models/movie_model.dart';

// ignore: must_be_immutable
class DetailMovie extends StatefulWidget {
  var dataDetail, dataBackup;
  DetailMovie({Key? key, this.dataDetail, this.dataBackup}) : super(key: key);

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
            child: Column(
              children: [
                if (widget.dataDetail.original_title != null)
                  Text('${widget.dataDetail?.original_title}'),
                if (widget.dataDetail.original_title == null)
                  Text('${widget.dataBackup?.original_title}'),
              ],
            )),
      ),
      body: Stack(children: [
        if (widget.dataDetail.poster_path != null)
          Positioned(
            bottom: 50,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                'https://image.tmdb.org/t/p/w500/${widget.dataDetail?.poster_path}',
              ),
            ),
          ),
        if (widget.dataDetail.poster_path == null)
          Positioned(
            bottom: 50,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                'https://image.tmdb.org/t/p/w500/${widget.dataBackup?.poster_path}',
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
                      if (widget.dataDetail.vote_average != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Rating: ${widget.dataDetail?.vote_average}'),
                        ),
                      if (widget.dataDetail.vote_average == null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Rating: ${widget.dataBackup?.vote_average}'),
                        ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              if (widget.dataDetail.original_title != null)
                                Text('${widget.dataDetail?.original_title}'),
                              if (widget.dataDetail.original_title == null)
                                Text('${widget.dataBackup?.original_title}'),
                            ],
                          )),
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
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                if (widget.dataDetail.runtime != null)
                                  Text(
                                      'Duration: ${widget.dataDetail?.runtime} Minutes'),
                                if (widget.dataBackup.runtime != null)
                                  Text(
                                      'Duration: ${widget.dataBackup?.runtime} Minutes'),
                                if (widget.dataBackup.runtime == null &&
                                    widget.dataDetail.runtime == null)
                                  Text('Duration: - Minutes'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            if (widget.dataDetail.overview != null)
                              Text(
                                '${widget.dataDetail?.overview}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            if (widget.dataDetail.overview == null)
                              Text(
                                '${widget.dataBackup?.overview}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                    ],
                  )),
            )),
      ]),
    );
  }
}
