import 'package:flutter/material.dart';

class CanvasDemoPage extends StatefulWidget {
  @override
  _CanvasDemoPageState createState() => _CanvasDemoPageState();
}

class _CanvasDemoPageState extends State<CanvasDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '绘制',
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 20,
        ),
        child: CustomPaint(
          size: Size(MediaQuery.of(context).size.width - 20, 40),
          painter: CanvasDemoPainter(),
        ),
      ),
    );
  }
}

class CanvasDemoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 24;
    double eHeight = 40;

    //網格背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = Colors.red; //背景为纸黄色
    canvas.drawRect(Offset.zero & size, paint);

    var progressPaint = Paint()..isAntiAlias = true;

    //網格風格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Color(0xff25272c)
      ..strokeWidth = 1.1;

    progressPaint
      ..style = PaintingStyle.fill
      ..color = Colors.yellow
      ..strokeWidth = 10;

    for (int i = 0; i <= 1; ++i) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i <= 24; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, eHeight), paint);
    }

    canvas.drawRect(Offset(0.0, 0.0) & Size(eWidth, eHeight), progressPaint);

    canvas.drawRect(
        Offset(eWidth * 3, 0.0) & Size(eWidth, eHeight), progressPaint);

    canvas.drawRect(
        Offset(eWidth * 8, 0.0) & Size(eWidth, eHeight), progressPaint);
  }

  @override
  bool shouldRepaint(CanvasDemoPainter oldDelegate) => this != oldDelegate;

  @override
  bool shouldRebuildSemantics(CanvasDemoPainter oldDelegate) =>
      this != oldDelegate;
}
