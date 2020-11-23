import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ContainerDemo extends StatefulWidget {
  @override
  _ContainerDemoState createState() => _ContainerDemoState();
}

class _ContainerDemoState extends State<ContainerDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('container demo'),
      ),
      body: _buildView(),
    );
  }

  Widget _buildView() {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 300,
        minHeight: 200,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
          color: Colors.red,
        ),
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        image: DecorationImage(
          image: NetworkImage(
            'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2319772070,3114389419&fm=26&gp=0.jpg',
          ),
          centerSlice: Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 80),
      alignment: Alignment.center,
      child: Text(
        'hello word',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      transform: Matrix4.rotationZ(0.4),
    );
  }
}
