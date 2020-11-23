import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AnimationDiffDemoPage extends StatefulWidget {
  @override
  _AnimationDiffDemoPageState createState() => _AnimationDiffDemoPageState();
}

class _AnimationDiffDemoPageState extends State<AnimationDiffDemoPage>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000),
        vsync: this); //初始化，动画控制器,每个动画都是执行2秒
  }

  @override
  void dispose() {
    controller.dispose(); //销毁释放
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await controller.forward()?.orCancel;
      await controller.reverse()?.orCancel;
    } on TickerCanceled {
      print('animation falied');
    }
  }

  @override
  Widget build(BuildContext context) {
    // timeDilation = 10.0;
    return Scaffold(
      appBar: AppBar(
        title: Text("组合动画"),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, //自己处理事件
        onTap: () {
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            child: StaggedAnimationDemo(
              controller: controller.view,
            ),
          ),
        ),
      ),
    );
  }
}

class StaggedAnimationDemo extends StatelessWidget {
  //Curves.ease一种三次动画曲线，速度快，结束慢
  final Animation<double> controller;
  final Animation<double> bezier; //透明度渐变
  final Animation<double> width; //宽度变化
  final Animation<double> height; //高度变化
  final Animation<EdgeInsets> drift; //位移变化
  final Animation<BorderRadius> borderRadius; //圆角变化
  final Animation<Color> color; //颜色变化
  StaggedAnimationDemo({Key key, this.controller})
      : bezier = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.0, 0.1, curve: Curves.ease),
        )),
        width = Tween<double>(
          begin: 50.0,
          end: 150.0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.125, 0.250, curve: Curves.ease),
        )),
        height = Tween<double>(
          begin: 50.0,
          end: 150.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.250, 0.375, curve: Curves.ease),
          ),
        ),
        drift = EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 16.0),
          end: const EdgeInsets.only(bottom: 75.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.375, 0.5, curve: Curves.ease),
          ),
        ),
        borderRadius = BorderRadiusTween(
          begin: BorderRadius.circular(4.0),
          end: BorderRadius.circular(75.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 0.75, curve: Curves.ease),
          ),
        ),
        color = ColorTween(
          begin: Colors.indigo[100],
          end: Colors.orange[400],
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.75, 1.0, curve: Curves.ease),
          ),
        ),
        super(key: key);

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      padding: drift.value,
      alignment: Alignment.bottomCenter,
      child: Opacity(
        //透明组件
        opacity: bezier.value,
        child: Container(
          width: width.value,
          height: height.value,
          decoration: BoxDecoration(
            color: color.value,
            border: Border.all(color: Colors.indigo[300], width: 3.0),
            borderRadius: borderRadius.value,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
