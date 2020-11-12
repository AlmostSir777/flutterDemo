import 'package:flutter/material.dart';

class AnimationBottomPage extends StatefulWidget {
  @override
  _AnimationBottomPageState createState() => _AnimationBottomPageState();
}

const double height = 300.0;

class _AnimationBottomPageState extends State<AnimationBottomPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: height,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    double contentHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBar(
        title: Text('bottom动画'),
      ),
      body: GestureDetector(
        onTap: () {
          if (_animationController.status == AnimationStatus.completed) {
            _animationController.reverse();
          } else if (_animationController.status == AnimationStatus.dismissed) {
            _animationController.forward();
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: contentHeight,
          color: Colors.black.withOpacity(0.3),
          alignment: Alignment.bottomCenter,
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Positioned(
                child: Container(
                  color: Colors.orange,
                  width: MediaQuery.of(context).size.width,
                  height: height,
                  child: Center(
                    child: Text(
                      '测试测试',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
                ),
                left: 0,
                top: contentHeight - _animation.value ?? 0,
                height: height,
                width: MediaQuery.of(context).size.width,
              )
            ],
          ),
        ),
      ),
    );
  }
}
