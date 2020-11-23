import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AnimationView extends AnimatedWidget {
  static final Tween _opacityTween = Tween<double>(begin: 0.1, end: 1.0);
  static final Tween _sizeTween = Tween<double>(begin: 0.0, end: 300);

  AnimationView({
    Key key,
    Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          width: _sizeTween.evaluate(animation),
          height: _sizeTween.evaluate(animation),
          child: FlutterLogo(),
        ),
      ),
    );
  }
}

class CustomAnimationView extends StatefulWidget {
  @override
  _CustomAnimationViewState createState() => _CustomAnimationViewState();
}

class _CustomAnimationViewState extends State<CustomAnimationView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('组合动画')),
      body: AnimationView(animation: _animation),
    );
  }
}
