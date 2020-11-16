import 'package:flutter/material.dart';
import 'tabbar/root_view_page.dart';

import './base/config.dart';
import 'controller/homePage/home_page_routes.dart';
import 'controller/settingPage/setting_page_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff4782f6),
      ),
      home: RootPage(),
      routes: _getPageRoutes(context),
    );
  }

  Map<String, Widget Function(BuildContext)> _getPageRoutes(
      BuildContext context) {
    Map<String, Widget Function(BuildContext)> pageRoutes = Map();
    // 首页路由
    pageRoutes.addAll(HomePageRoutes.getHomePageRoutes(context));
    // 设置路由
    pageRoutes.addAll(SettingPageRoutes.getSettingPageRoutes(context));
    return pageRoutes;
  }
}
