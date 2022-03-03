import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pilar/models/movie_model.dart';
import 'package:pilar/view/offline_page.dart';

// ignore: must_be_immutable
class DetailMovie extends StatefulWidget {
  var dataDetail, dataBackup;
  DetailMovie({Key? key, this.dataDetail, this.dataBackup}) : super(key: key);

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

BuildContext? dialogContext;

class _DetailMovieState extends State<DetailMovie> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_connectionStatus.toString().contains('none')) {
      return OfflinePage();
    }
    Future.delayed(
        Duration.zero,
        () => {
              if (widget.dataDetail.original_title == null ||
                  widget.dataDetail.poster_path == null ||
                  widget.dataDetail.vote_average == null ||
                  widget.dataDetail.runtime == null ||
                  widget.dataDetail.overview == null ||
                  widget.dataDetail.id != widget.dataBackup.id)
                showAlert(context)
            });
    return Scaffold(
      appBar: AppBar(
        title: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                // cekDataSource(),
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

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        dialogContext = context;
        return AlertDialog(
          title: Text("Warning"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("Cant get real data,\nData source from Backup Data"),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext!);
                },
                child: Text('Close'))
          ],
        );
      },
    );
  }
}
