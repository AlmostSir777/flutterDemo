import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AnimationDiffDemoPage extends StatefulWidget {
  @override
  _AnimationDiffDemoPageState createState() => _AnimationDiffDemoPageState();
}

class _AnimationDiffDemoPageState extends State<AnimationDiffDemoPage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(microseconds: 2000));
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future _playAnimation() async {
    try {
      await _controller.forward()?.orCancel;
      // await _controller.reverse()?.orCancel;
    } on TickerCanceled {
      print('animation falied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('复杂动画'),
      ),
      body: GestureDetector(
        onTap: () => _playAnimation(),
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                border: Border.all(
                  color: Colors.black.withOpacity(0.5),
                )),
            child: StaggedAnimation(
              controller: _controller,
            ),
          ),
        ),
      ),
    );
  }
}

class StaggedAnimation extends StatelessWidget {
  final Animation<double> controller;
  Animation<double> bezier;
  Animation<double> width;
  Animation<double> height;
  Animation<EdgeInsets> drift;
  Animation<BorderRadius> borderRadius;
  Animation<Color> color;

  StaggedAnimation({Key key, this.controller}) : super(key: key) {
    bezier = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 0.1, curve: Curves.ease),
    ));
    width = Tween<double>(begin: 50.0, end: 150.0).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.125, 0.250, curve: Curves.ease),
    ));
    height = Tween<double>(begin: 50.0, end: 150.0).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.250, 0.375, curve: Curves.ease),
    ));
    drift = EdgeInsetsTween(
            begin: EdgeInsets.only(bottom: 16.0),
            end: EdgeInsets.only(bottom: 75.0))
        .animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.375, 0.5, curve: Curves.ease),
    ));
    borderRadius = BorderRadiusTween(
            begin: BorderRadius.circular(4.0), end: BorderRadius.circular(75))
        .animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.5, 0.75, curve: Curves.ease),
    ));
    color = ColorTween(begin: Colors.indigo[180], end: Colors.orange[400])
        .animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.75, 1.0, curve: Curves.ease),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Container(
          padding: drift.value,
          alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: bezier.value,
            child: Container(
              width: width.value,
              height: height.value,
              decoration: BoxDecoration(
                color: color.value,
                border: Border.all(
                  color: Colors.indigo[300],
                  width: 3.0,
                ),
                borderRadius: borderRadius.value,
              ),
            ),
          ),
        );
      },
    );
  }
}
