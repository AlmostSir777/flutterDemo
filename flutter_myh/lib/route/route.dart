import 'package:flutter/material.dart';

import '../controller/home_page/home_page_routes.dart';
import '../controller/setting_page/setting_page_routes.dart';

class AppRoute {
  static Map<String, Widget Function(BuildContext)> getPageRoutes(
      BuildContext context) {
    Map<String, Widget Function(BuildContext)> pageRoutes = Map();
    // 首页路由
    pageRoutes.addAll(HomePageRoutes.getHomePageRoutes(context));
    // 设置路由
    pageRoutes.addAll(SettingPageRoutes.getSettingPageRoutes(context));
    return pageRoutes;
  }
}
