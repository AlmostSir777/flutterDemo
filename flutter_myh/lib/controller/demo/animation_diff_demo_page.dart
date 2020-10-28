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
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('组合动画'),
      ),
    );
  }
}

class StaggedAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
