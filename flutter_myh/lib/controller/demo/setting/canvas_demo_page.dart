import 'package:flutter/material.dart';
import '../../../base/common_util.dart';

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
          left: CommonUtil.scaleWidth(24),
          right: CommonUtil.scaleWidth(24),
          top: CommonUtil.scaleWidth(40),
        ),
        child: CustomPaint(
          size: Size(CommonUtil.screenWidth - CommonUtil.scaleWidth(48),
              CommonUtil.scaleHeight(120)),
          painter: CanvasDemoPainter(),
        ),
      ),
    );
  }
}

class CanvasDemoPainter extends CustomPainter {
  final int number; //平分多少份
  Map _caches = Map();
  double eWidth; // 绘制进度宽度
  double eHeight; // 绘制进度高度
  Size topSize; // 刻度size
  CanvasDemoPainter({this.number = 24}) {
    double width = CommonUtil.screenWidth - CommonUtil.scaleWidth(48);
    eWidth = width / number;
    eHeight = CommonUtil.scaleWidth(50);
    topSize = Size(width, eHeight);
  }

  TextPainter _builderTextPainter(
    String text,
    double width,
    Color color,
  ) {
    return TextPainter(
      text: TextSpan(
        text: text ?? '',
        style: TextStyle(
          fontSize: CommonUtil.scaleWidth(24),
          color: color,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: width, maxWidth: width);
  }

  @override
  void paint(Canvas canvas, Size size) {
    //網格背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = Colors.green.withOpacity(0.4); //背景为纸黄色
    canvas.drawRect(Offset.zero & topSize, paint);

    var progressPaint = Paint()..isAntiAlias = true;

    //網格風格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.white
      ..strokeWidth = 0.5;

    progressPaint
      ..style = PaintingStyle.fill
      ..color = Colors.green
      ..strokeWidth = 10;

    canvas.drawRect(Offset(0.0, 0.0) & Size(eWidth, eHeight), progressPaint);

    canvas.drawRect(
        Offset(eWidth * 3, 0.0) & Size(eWidth, eHeight), progressPaint);

    canvas.drawRect(
        Offset(eWidth * 8, 0.0) & Size(eWidth, eHeight), progressPaint);

    for (int i = 0; i <= number; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, eHeight), paint);
    }

    for (int i = 0; i <= number; i += 2) {
      TextPainter textPaint = _caches['_textPaint${i.toString()}'];
      if (textPaint == null) {
        textPaint = _builderTextPainter(
          i.toString(),
          CommonUtil.scaleWidth(40),
          Colors.black,
        );
        _caches['_textPaint${i.toString()}'] = textPaint;
      }
      double width = textPaint.width;
      double itemWidth =
          (CommonUtil.screenWidth - CommonUtil.scaleWidth(24) * 2) /
              number.toDouble();
      double leftSpace = i * itemWidth - 0.5 * width;
      textPaint.paint(
          canvas, Offset(leftSpace, eHeight + CommonUtil.scaleHeight(15)));
    }
  }

  @override
  bool shouldRepaint(CanvasDemoPainter oldDelegate) => this != oldDelegate;

  @override
  bool shouldRebuildSemantics(CanvasDemoPainter oldDelegate) =>
      this != oldDelegate;
}
