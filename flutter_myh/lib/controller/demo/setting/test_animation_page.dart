import 'package:flutter/material.dart';

class TestAnimationPage extends StatefulWidget {
  @override
  _TestAnimationPageState createState() => _TestAnimationPageState();
}

class _TestAnimationPageState extends State<TestAnimationPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<EdgeInsets> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(
          seconds: 1,
        ));
    _animation = Tween<EdgeInsets>(
            begin: EdgeInsets.only(
              top: 50,
              left: 100,
            ),
            end: EdgeInsets.only(
              top: 200,
              left: 200,
            ))
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeIn));
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.addStatusListener((status) {
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
      appBar: AppBar(
        title: Text('基础练习'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: _animation.value,
      child: Container(
        color: Colors.yellow,
        width: 100,
        height: 100,
      ),
    );
  }
}
