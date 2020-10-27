import 'package:flutter/material.dart';
import 'tabbar/root_view_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff4782f6),
      ),
      home: RootPage(),
    );
  }
}
