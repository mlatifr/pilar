import 'package:flutter/material.dart';

class OfflinePage extends StatefulWidget {
  var title;
  OfflinePage({Key? key, this.title}) : super(key: key);

  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title,
      ),
      body: Center(child: Text('No Internet Connection')),
    );
  }
}
