import 'package:flutter/material.dart';

class GestureDemoPage extends StatefulWidget {
  @override
  _GestureDemoPageState createState() => _GestureDemoPageState();
}

class _GestureDemoPageState extends State<GestureDemoPage> {
  double _topDistance = 80.0;
  double _leftDistance = 80.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手势练习'),
      ),
      body: Center(
        child: Container(
          color: Colors.lightGreen,
          width: 400,
          height: 400,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: _leftDistance,
                top: _topDistance,
                child: Listener(
                  onPointerDown: (event) {
                    print('down');
                  },
                  onPointerUp: (event) {
                    print('up');
                  },
                  child: GestureDetector(
                    child: CircleAvatar(
                      child: Text('A'),
                    ),
                    onPanUpdate: (details) {
                      setState(() {
                        _leftDistance += details.delta.dx;
                        _topDistance += details.delta.dy;
                      });
                    },
                    onPanEnd: (details) {
                      print(details.velocity);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
