import 'package:flutter/material.dart';

class DetailMovie extends StatefulWidget {
  const DetailMovie({Key? key}) : super(key: key);

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
            alignment: Alignment.center, child: Text('Title Movie')),
      ),
      body: Stack(children: [
        Image.network(
          'https://image.tmdb.org/t/p/w500/1BIoJGKbXjdFDAqUEiA2VHqkK1Z.jpg',
          height: MediaQuery.of(context).size.height,
        ),
        //detail movie widget
        Positioned(
            top: MediaQuery.of(context).size.height / 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blue,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Rating'),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Judul'),
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
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text('Durasi'),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Sinopsis: Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrs standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has sur ',
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
