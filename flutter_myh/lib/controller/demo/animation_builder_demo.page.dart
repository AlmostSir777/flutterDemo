import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AnimationBuildDemoPage extends StatefulWidget {
  @override
  _AnimationBuildDemoPageState createState() => _AnimationBuildDemoPageState();
}

class _AnimationBuildDemoPageState extends State<AnimationBuildDemoPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = IntTween(begin: 0, end: 255).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.2,
          0.8,
          curve: Curves.easeIn,
        )));
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    super.initState();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('animationBuilderDemo')),
      body: AnimatedBuilder(
        animation: _animation,
        builder: (_, __) {
          return Container(
            child: __,
            color: Color.fromARGB(_animation.value, 255, 1, 1),
          );
        },
        child: Center(
          child: Text('渐变动画'),
        ),
      ),
    );
  }
}
