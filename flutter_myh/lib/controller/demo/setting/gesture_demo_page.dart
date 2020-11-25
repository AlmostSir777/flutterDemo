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
    double containerWidth = 400.0;
    double itemWidth = 40;
    double min = 5.0;
    double max = containerWidth - itemWidth - min;
    return Scaffold(
      appBar: AppBar(
        title: Text('手势练习'),
      ),
      body: Center(
        child: Container(
          color: Colors.lightGreen,
          width: containerWidth,
          height: containerWidth,
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
                    child: Container(
                      color: Colors.yellow,
                      width: itemWidth,
                      height: itemWidth,
                      alignment: Alignment.center,
                      child: Text('A'),
                    ),
                    onPanUpdate: (details) {
                      print('x' +
                          details.delta.dx.toString() +
                          '\n' +
                          'y' +
                          details.delta.dy.toString());
                      setState(() {
                        _leftDistance += details.delta.dx;
                        _topDistance += details.delta.dy;
                        if (_leftDistance <= min) {
                          _leftDistance = min;
                        } else if (_leftDistance >= max) {
                          _leftDistance = max;
                        }
                        if (_topDistance <= min) {
                          _topDistance = min;
                        } else if (_topDistance >= max) {
                          _topDistance = max;
                        }
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
