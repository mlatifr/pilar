import 'package:flutter/material.dart';
import 'package:pilar/providers/movie_provider.dart';
import 'package:pilar/singletons/offlinepage.dart';
import 'package:pilar/view/home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    ConnectionStatus.getInstance().initialize(navigatorKey);
    return MultiProvider(
      providers:   [
        ChangeNotifierProvider(
          create: (_) => MovieProviders(),
        ), 
      ],
      child: ScreenUtilInit(
        builder: () => const MaterialApp(
          title: 'Movie Pillar',
          debugShowCheckedModeBanner: false, 
          home: HomePage(),
        ),
      ),
    );
  }
}
 
