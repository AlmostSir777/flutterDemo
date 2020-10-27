import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/homePage/home_page.dart';
import '../controller/settingPage/setting_page.dart';
import '../test_model.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  TabbarSelectModel tabModel;
  List<BottomNavigationBarItem> _tabBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.access_alarm),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.access_time),
      title: Text('设置'),
    )
  ];

  @override
  void initState() {
    tabModel = TabbarSelectModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TabbarSelectModel>(
      create: (_) => tabModel,
      builder: (_, __) {
        return Selector<TabbarSelectModel, int>(
          builder: (_, index, __) {
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                items: _tabBarItems,
                onTap: (int index) => tabModel.changeTabbarIndex(index),
                type: BottomNavigationBarType.fixed,
                fixedColor: Colors.green,
                currentIndex: index,
              ),
              body: IndexedStack(
                children: <Widget>[
                  HomeActivity(),
                  SettingController(),
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
