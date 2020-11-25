import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import '../setting_page/setting_page_routes.dart';

class SettingAnimationPage extends StatefulWidget {
  @override
  _SettingAnimationPageState createState() => _SettingAnimationPageState();
}

class _SettingAnimationPageState extends State<SettingAnimationPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 500,
        ));
    animation = Tween<double>(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        print('${animation.value}');
        setState(() {});
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: _buildListView(),
      ),
    );
  }

  Widget _buildListView() {
    List<String> list = [
      '单一动画',
      '组合动画',
      'animationBuilder应用',
      '复杂动画',
      '动画练习',
      '底部弹出动画练习',
    ];
    return ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int row) {
          return GestureDetector(
            onTap: () {
              if (row == 0) {
                Navigator.pushNamed(context, SettingPageRoutes.animationNormal);
              } else if (row == 1) {
                Navigator.pushNamed(context, SettingPageRoutes.animationCustom);
              } else if (row == 2) {
                Navigator.pushNamed(
                    context, SettingPageRoutes.animationBuilder);
              } else if (row == 3) {
                Navigator.pushNamed(context, SettingPageRoutes.animationDiff);
              } else if (row == 4) {
                Navigator.pushNamed(context, SettingPageRoutes.animationTest);
              } else if (row == 5) {
                Navigator.pushNamed(context, SettingPageRoutes.animationBottom);
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              color: Colors.white,
              child: Center(
                child: Text('${list[row]}'),
              ),
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
