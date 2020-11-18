import 'package:flutter/material.dart';

import '../../model/root_page_model.dart';

class HomeDetailVC extends StatefulWidget {
  final ListModel model;
  const HomeDetailVC({
    this.model,
  });
  @override
  _HomeDetailVCState createState() => _HomeDetailVCState();
}

class _HomeDetailVCState extends State<HomeDetailVC>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ListModel _model;
  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      _model = widget.model;
    }
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    if (args != null && _model == null) {
      _model = args;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('详情'),
        leading: null,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: RaisedButton(
          color: Colors.blue,
          onPressed: () {
            /*返回数据*/
            _model.name = '王二麻子';
            Navigator.of(context).pop(_model);
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
