import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import '../demo/animation_demo_page.dart';
import '../demo/animation_demo_custom_page.dart';
import '../demo/animation_builder_demo.page.dart';

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
    ];
    return ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int row) {
          return GestureDetector(
            onTap: () {
              if (row == 0) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AnimationDemoPage();
                }));
              } else if (row == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CustomAnimationView();
                }));
              } else if (row == 2) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AnimationBuildDemoPage();
                }));
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
