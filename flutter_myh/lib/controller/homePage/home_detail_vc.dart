import 'package:flutter/material.dart';

import '../../test_model.dart';

class HomeDetailVC extends StatefulWidget {
  final ListModel model;
  const HomeDetailVC({
    @required this.model,
  });
  @override
  _HomeDetailVCState createState() => _HomeDetailVCState();
}

class _HomeDetailVCState extends State<HomeDetailVC>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    print(widget.model.name);
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('详情'),
      ),
      body: Center(
        child: RaisedButton(
          color: Colors.blue,
          onPressed: () {
            /*返回数据*/
            widget.model.name = '王二麻子';
            Navigator.of(context).pop(widget.model);
          },
          child: Text(
            "返回传值",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
