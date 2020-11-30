import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/home_page/home_page.dart';
import '../controller/setting_page/setting_page.dart';
import '../controller/theme_page/theme_page.dart';
import './model/root_page_model.dart';
import '../base/common_util.dart';
import '../base/app_manager.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  TabbarSelectModel _tabModel;
  List<BottomNavigationBarItem> _tabBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.explore),
      title: Text('例子'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      title: Text('设置'),
    ),
  ];

  @override
  void initState() {
    _tabModel = TabbarSelectModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 屏幕适配
    CommonUtil.initScreen(context);
    return ChangeNotifierProvider<TabbarSelectModel>(
      create: (_) => _tabModel,
      builder: (_, __) {
        return Selector<TabbarSelectModel, int>(
          builder: (_, index, __) {
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                items: _tabBarItems,
                onTap: (int index) => _tabModel.changeTabbarIndex(index),
                type: BottomNavigationBarType.fixed,
                fixedColor: AppManager.instance.themeData.primaryColor,
                currentIndex: index,
              ),
              body: IndexedStack(
                children: <Widget>[
                  HomeActivity(),
                  SettingController(),
                  ThemePage(),
                ],
                index: index,
              ),
            );
          },
          selector: (_, tabModel) => tabModel.index,
        );
      },
    );
  }
}
