import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(),
    );
  }
}
