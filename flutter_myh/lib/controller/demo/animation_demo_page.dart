import 'package:flutter/material.dart';

class AnimationDemoPage extends StatefulWidget {
  @override
  _AnimationDemoPageState createState() => _AnimationDemoPageState();
}

class _AnimationDemoPageState extends State<AnimationDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画学习'),
      ),
      body: AnimationDemoView(),
    );
  }
}

class AnimationDemoView extends StatefulWidget {
  @override
  _AnimationDemoViewState createState() => _AnimationDemoViewState();
}

class _AnimationDemoViewState extends State<AnimationDemoView>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastLinearToSlowEaseIn,
    ))
      ..addListener(() {
        setState(() {});
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
    return Opacity(
      opacity: _animation.value,
      child: Center(
        child: GestureDetector(
          child: Container(
            width: 400 * _animation.value,
            height: 400 * _animation.value,
            color: Colors.green,
          ),
          onTap: () {
            _animationController.value = 0.0;
            _animationController.forward();
          },
        ),
      ),
    );
  }
}
