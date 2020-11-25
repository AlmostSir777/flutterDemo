import 'package:flutter/material.dart';
import 'tabbar/root_view_page.dart';

import './base/config.dart';
import 'route/route.dart';
import './const/config.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: theme_color,
      ),
      home: RootPage(),
      routes: AppRoute.getPageRoutes(context),
    );
  }
}
