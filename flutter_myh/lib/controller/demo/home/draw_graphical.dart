import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_myh/base/app_manager.dart';

import '../demo_config.dart';

class DrawDemo extends StatefulWidget {
  @override
  _DrawDemoState createState() => _DrawDemoState();
}

class _DrawDemoState extends State<DrawDemo> {
  List<AngleModel> _Data = [];
  @override
  void initState() {
    super.initState();
    List<Color> _colors = [
      Colors.red,
      Colors.yellow,
      AppManager().themeData.primaryColor,
    ];
    List<int> _nums = [
      3,
      4,
      5,
    ];
    for (int i = 0; i < _colors.length; i++) {
      List<Coordinate> _list = [];
      for (int j = 0; j < _nums[i]; j++) {
        int x = (j + 1) * 10 + Random().nextInt(100);
        _list.add(Coordinate(x: x.toDouble(), y: x.toDouble()));
      }
      _Data.add(
        AngleModel(
          spots: _list,
          color: _colors[i],
          height: 200,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseNormalContainer(
      title: '绘制图形',
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _getChildren(),
        ),
      ),
    );
  }

  List<TriangleDrawView> _getChildren() {
    List<TriangleDrawView> _list = [];
    for (AngleModel value in _Data) {
      _list.add(
        TriangleDrawView(
          spots: value.spots,
          color: value.color,
          height: value.height,
        ),
      );
    }
    return _list;
  }
}

class TriangleDrawView extends StatelessWidget {
  final List<Coordinate> spots;
  final Color color;
  final double height;
  TriangleDrawView({
    @required this.spots,
    this.color,
    this.height = 200,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: CommonUtil.screenWidth,
      height: height,
      child: CustomPaint(
        painter: TriangleCustomPainter(
          spots: spots,
          color: color,
        ),
      ),
    );
  }
}

class TriangleCustomPainter extends CustomPainter {
  Paint _paint = Paint();
  final List<Coordinate> spots;
  final Color color;
  TriangleCustomPainter({
    @required this.spots,
    this.color,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()..moveTo(spots[0].x, spots[0].y);
    for (int i = 1; i < spots.length; i++) {
      Coordinate coo = spots[i];
      path.lineTo(coo.x, coo.y);
    }
    canvas.drawPath(
        path,
        _paint
          ..style = PaintingStyle.fill
          ..color = color);
  }

  @override
  bool shouldRepaint(TriangleCustomPainter oldDelegate) => this != oldDelegate;

  @override
  bool shouldRebuildSemantics(TriangleCustomPainter oldDelegate) =>
      this != oldDelegate;
}

class Coordinate {
  final double x;
  final double y;
  Coordinate({this.x, this.y});
}

class AngleModel {
  final List<Coordinate> spots;
  final Color color;
  final double height;
  AngleModel({
    @required this.spots,
    this.color,
    this.height,
  });
}
