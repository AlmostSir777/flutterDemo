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
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (_animationController.status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
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
  final Animation<double> rightMove; //底部滑动条变化
  final Animation<double> iconOp;
  final Animation<double> bottomOp;

  AnimationShowView({Key key, this.controller})
      : width = Tween<double>(
          begin: CommonUtil.screenWidth * 0.5,
          end: CommonUtil.screenWidth,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.0, 0.5, curve: Curves.ease),
        )),
        height = Tween<double>(
          begin: CommonUtil.screenHeight * 0.5,
          end: CommonUtil.screenHeight * 0.3,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.5, curve: Curves.ease),
          ),
        ),
        drift = EdgeInsetsTween(
          begin: EdgeInsets.only(
            left: 0.25 * CommonUtil.screenWidth,
            top: CommonUtil.screenHeight * 0.25,
          ),
          end: EdgeInsets.only(
            left: 0.0,
            top: 0.0,
          ),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.5, curve: Curves.ease),
          ),
        ),
        imageDrift = EdgeInsetsTween(
          begin: EdgeInsets.only(
            top: CommonUtil.screenHeight * 0.35,
            left: 100,
          ),
          end: EdgeInsets.only(
            top: CommonUtil.screenHeight * 0.3 - 50,
            left: CommonUtil.screenWidth * 0.5 - 50,
          ),
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
            curve: Interval(0.0, 0.5, curve: Curves.ease),
          ),
        ),
        rightMove = Tween<double>(
          begin: -140,
          end: 0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.5, 1.0, curve: Curves.ease),
        )),
        iconOp = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.3, 1.0, curve: Curves.linear),
        )),
        bottomOp = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.0, 0.3, curve: Curves.linear),
        )),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Container(
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Positioned(
                left: drift.value.left,
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
                bottom: 100,
                right: 180,
                child: Opacity(
                  opacity: iconOp.value,
                  child: Container(
                    color: Colors.black,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              Positioned(
                bottom: 100.0,
                right: rightMove.value,
                child: Opacity(
                  opacity: bottomOp.value,
                  child: Container(
                    alignment: Alignment(0, 0),
                    decoration: BoxDecoration(
                      color: AppManager().themeData.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(22.5),
                        topLeft: Radius.circular(22.5),
                      ),
                    ),
                    width: 160,
                    height: 45,
                    child: Text(
                      '智能练习',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
