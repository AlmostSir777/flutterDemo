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
  Animation<EdgeInsets> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    // _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //   parent: _animationController,
    //   curve: Curves.easeInOut,
    // ))
    _animation = EdgeInsetsTween(
            begin: EdgeInsets.only(top: 0), end: EdgeInsets.only(top: 250))
        .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
            setState(() {});
          });
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void _startAniamtion() async {
    try {
      await _animationController.reverse().orCancel;
      await _animationController.forward().orCancel;
    } on TickerCanceled {
      print('animation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1,
      child: Align(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          child: Container(
            margin: _animation.value,
            width: 300,
            height: 300,
            color: Colors.green,
          ),
          onTap: () {
            // _animationController.value = 0.0;
            _startAniamtion();
          },
        ),
      ),
    );
  }
}
