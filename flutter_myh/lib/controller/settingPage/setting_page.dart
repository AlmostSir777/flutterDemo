import 'package:flutter/material.dart';

import 'setting_timer_page.dart';
import 'setting_textfield_page.dart';

class SettingController extends StatefulWidget {
  @override
  _SettingControllerState createState() => _SettingControllerState();
}

class _SettingControllerState extends State<SettingController>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List tabList;
  @override
  void initState() {
    tabList = ['电影', '读书', '新闻'];
    tabController = TabController(
      length: tabList.length,
      vsync: this,
      initialIndex: 1,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [];
    for (String item in tabList) {
      tabs.add(Tab(
        text: item,
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
        backgroundColor: Colors.red,
        bottom: TabBar(
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelColor: Colors.white54,
          labelColor: Colors.white,
          labelStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          controller: tabController,
          tabs: tabs,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          SettingTimerPage(),
          SettingTextFieldPage(),
          Container(
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
