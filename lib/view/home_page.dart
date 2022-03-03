import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pilar/providers/movie_provider.dart';
import 'package:pilar/view/offline_page.dart';
import 'package:pilar/widget/movie_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

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
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Pilar Movies')),
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
}
