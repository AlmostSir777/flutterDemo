import 'package:flutter/material.dart';
import 'package:flutter_myh/base/app_manager.dart';

import '../demo_config.dart';

class AnimationTestDemo extends StatefulWidget {
  @override
  _AnimationTestDemoState createState() => _AnimationTestDemoState();
}

class _AnimationTestDemoState extends State<AnimationTestDemo>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await _animationController.forward()?.orCancel;
      await _animationController.reverse()?.orCancel;
    } on TickerCanceled {
      print('animation falied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseNormalContainer(
      title: '动画练习',
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, //自己处理事件
        onTap: () {
          _playAnimation();
        },
        child: AnimationShowView(
          controller: _animationController.view,
        ),
      ),
    );
  }
}

class AnimationShowView extends StatelessWidget {
  final Animation<double> controller;
  final Animation<double> width; //宽度变化
  final Animation<double> height; //高度变化
  final Animation<EdgeInsets> drift; //位移变化
  final Animation<EdgeInsets> imageDrift; //位移变化
  final Animation<BorderRadius> borderRadius; //圆角变化
  final Animation<double> rightMove; //圆角变化
  AnimationShowView({Key key, this.controller})
      : width = Tween<double>(
          begin: CommonUtil.screenWidth * 0.5,
          end: CommonUtil.screenWidth,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.0, 0.75, curve: Curves.ease),
        )),
        height = Tween<double>(
          begin: CommonUtil.screenHeight * 0.5,
          end: CommonUtil.screenHeight * 0.3,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.75, curve: Curves.ease),
          ),
        ),
        drift = EdgeInsetsTween(
          begin: EdgeInsets.only(
            top: CommonUtil.screenHeight * 0.25,
          ),
          end: EdgeInsets.only(top: 0.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.75, curve: Curves.ease),
          ),
        ),
        imageDrift = EdgeInsetsTween(
          begin: EdgeInsets.only(
            top: CommonUtil.screenHeight * 0.35,
          ),
          end: EdgeInsets.only(top: 100.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.75, curve: Curves.ease),
          ),
        ),
        borderRadius = BorderRadiusTween(
          begin: BorderRadius.circular(40.0),
          end: BorderRadius.circular(0.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.75, curve: Curves.ease),
          ),
        ),
        rightMove = Tween<double>(
          begin: -120,
          end: 0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.75, 1.0, curve: Curves.ease),
        )),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    double backLeft = (CommonUtil.screenWidth - width.value) * 0.5;
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Container(
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Positioned(
                left: backLeft,
                top: drift.value.top,
                width: width.value,
                height: height.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppManager().themeData.primaryColor,
                    borderRadius: borderRadius.value,
                  ),
                ),
              ),
              Positioned(
                left: imageDrift.value.left,
                top: imageDrift.value.top,
                child: FlutterLogo(
                  size: 100.0,
                ),
              ),
              Positioned(
                bottom: 100.0,
                right: rightMove.value,
                child: Container(
                  width: 160,
                  height: 20,
                  color: AppManager().themeData.primaryColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
