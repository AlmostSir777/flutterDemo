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
  bool _isPlaying;
  @override
  void initState() {
    super.initState();
    _isPlaying = false;
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
        _animationController.reverse().whenComplete(() {
          setState(() {
            _isPlaying = false;
          });
        });
      } else if (_animationController.status == AnimationStatus.dismissed) {
        setState(() {
          _isPlaying = true;
        });
        _animationController.forward();
      }
    } on TickerCanceled {
      print('animation falied');
    }
  }

  void _jump() {
    Navigator.pushNamed(
      context,
      HomePageRoutes.customAnimationDemo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // title: '动画练习',
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, //自己处理事件
        onDoubleTap: () {
          Navigator.pop(context);
        },
        onTap: () {
          // _playAnimation();
          _jump();
        },
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0.25 * CommonUtil.screenWidth,
              top: CommonUtil.screenHeight * 0.25,
              width: CommonUtil.screenWidth * 0.5,
              height: CommonUtil.screenHeight * 0.5,
              child: Opacity(
                opacity: _isPlaying ? 0.0 : 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppManager().themeData.primaryColor,
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              ),
            ),
            Positioned(
              top: CommonUtil.screenHeight * 0.5 - 50,
              left: 60.0,
              child: Opacity(
                opacity: _isPlaying ? 0.0 : 1.0,
                child: FlutterLogo(
                  size: 100.0,
                ),
              ),
            ),
            Positioned(
              top: CommonUtil.screenHeight * 0.75 - 80,
              left: 0.25 * CommonUtil.screenWidth,
              width: 0.5 * CommonUtil.screenWidth,
              child: Opacity(
                opacity: _isPlaying ? 0.0 : 1.0,
                child: Center(
                  child: Text('语文',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      )),
                ),
              ),
            ),
            Opacity(
              opacity: _isPlaying ? 1.0 : 0.0,
              child: AnimationShowView(
                key: UniqueKey(),
                controller: _animationController.view,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAnimationDemo extends StatefulWidget {
  @override
  _CustomAnimationDemoState createState() => _CustomAnimationDemoState();
}

class _CustomAnimationDemoState extends State<CustomAnimationDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        AnimationShowView(
          key: UniqueKey(),
          controller: _controller.view,
        ),
        Positioned(
          top: CommonUtil.statusBarHeight + 10,
          left: 15,
          child: GestureDetector(
            onTap: () {
              _controller.reverse()..whenComplete(() => Navigator.pop(context));
            },
            child: Image.asset('lib/assets/images/nav_back_white.png'),
          ),
        ),
      ]),
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
  final Animation<double> rightMove1; //底部滑动条变化
  final Animation<double> rightMove2; //底部滑动条变化
  final Animation<double> iconOp; //图片透明度
  final Animation<double> bottomOp; //按钮透明度
  final Animation<double> titleTop; // 文字距顶部
  final Animation<double> fontSize; // 文字大小

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
            top: CommonUtil.screenHeight * 0.5 - 50,
            left: 60,
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
        titleTop = Tween<double>(
          begin: CommonUtil.screenHeight * 0.75 - 80,
          end: CommonUtil.statusBarHeight + 10,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.5, curve: Curves.ease),
          ),
        ),
        fontSize = Tween<double>(
          begin: 22.0,
          end: 15.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.5, curve: Curves.ease),
          ),
        ),
        rightMove1 = Tween<double>(
          begin: -140,
          end: 0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.5, 0.75, curve: Curves.easeIn),
        )),
        rightMove2 = Tween<double>(
          begin: -140,
          end: 0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.75, 1.0, curve: Curves.easeIn),
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
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                left: 0,
                top: CommonUtil.screenHeight * 0.3 + 100.0,
                width: CommonUtil.screenWidth,
                height: 200.0,
                child: PageView.builder(
                  itemCount: 3,
                  itemBuilder: (_, int row) {
                    return Center(
                      child: Container(
                        width: CommonUtil.screenWidth * 0.5,
                        child: Text(
                          '1daskdjasdasdajsdlasdjaskdjasldksajdjalskdkjasljkdljkasjdajksdkdasdasdasdasdasas9',
                          maxLines: 10,
                          style: TextStyle(
                            fontSize: 15,
                            color: text_color,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
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
                top: titleTop.value,
                left: 0.25 * CommonUtil.screenWidth,
                width: 0.5 * CommonUtil.screenWidth,
                child: Center(
                  child: Text('语文',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize.value,
                      )),
                ),
              ),
              Positioned(
                bottom: 100.0,
                right: rightMove2.value,
                child: Opacity(
                  opacity: bottomOp.value,
                  child: Container(
                    alignment: Alignment(0, 0),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(22.5),
                        topLeft: Radius.circular(22.5),
                      ),
                    ),
                    width: 160,
                    height: 45,
                    child: Text(
                      '练习记录',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 160.0,
                right: rightMove1.value,
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
              Positioned(
                right: 180,
                bottom: 160,
                child: Opacity(
                  opacity: iconOp.value,
                  child: Container(
                    color: Colors.red,
                    width: 45,
                    height: 45,
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
