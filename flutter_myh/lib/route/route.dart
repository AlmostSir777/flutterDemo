import 'package:flutter/material.dart' hide Page;
import 'package:fish_redux/fish_redux.dart';

import '../controller/home_page/home_page_routes.dart';
import '../controller/setting_page/setting_page_routes.dart';
import '../controller/setting_page/setting_config.dart';
import '../base/push_route_tool.dart';

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

  static Route<dynamic> getCustomPages(RouteSettings settings) {
    Map<String, Page<Object, dynamic>> pages = {
      SettingPageRoutes.fishRedux: FishReduxDemoPage(),
    };

    Map views = {};
    views.addAll(HomePageRoutes.getCustomPageRoutes());
    views[SettingPageRoutes.clipDetail] = ImageDetail();

    PageRoutes routes = PageRoutes(pages: pages);
    animationType type = animationType.slider;
    if (settings.name == HomePageRoutes.subjectPage) {
      type = animationType.scale;
    } else if (settings.name == HomePageRoutes.paddingAlignCenter) {
      type = animationType.fade;
    } else if (settings.name == SettingPageRoutes.clipDetail) {
      type = animationType.fade;
    }
    return AnimationCustomRoute(
      type: type,
      widget: views[settings.name] ??
          routes.buildPage(
            settings.name,
            settings.arguments,
          ),
    );
  }
}
