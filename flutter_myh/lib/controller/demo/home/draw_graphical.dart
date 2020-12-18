import 'package:flutter/material.dart';
import 'package:flutter_myh/base/app_manager.dart';
import '../demo_config.dart';

class DrawDemo extends StatefulWidget {
  @override
  _DrawDemoState createState() => _DrawDemoState();
}

class _DrawDemoState extends State<DrawDemo> {
  @override
  Widget build(BuildContext context) {
    return BaseNormalContainer(
      title: '绘制图形',
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TriangleDrawView(),
          ],
        ),
      ),
    );
  }
}

class TriangleDrawView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Coordinate> leftSpots = [
      Coordinate(x: 100, y: 10),
      Coordinate(x: 200, y: 10),
      Coordinate(x: 150, y: 80),
    ];
    return Container(
      width: CommonUtil.screenWidth,
      height: CommonUtil.scaleHeight(200),
      child: CustomPaint(
        painter: TriangleCustomPainter(
          spots: leftSpots,
          color: AppManager().themeData.primaryColor,
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
    Path path = Path()
      ..moveTo(spots[0].x, spots[0].y)
      ..lineTo(spots[1].x, spots[1].y)
      ..lineTo(spots[2].x, spots[2].y);
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
