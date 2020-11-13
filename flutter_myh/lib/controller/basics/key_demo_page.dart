import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

class KeyDemoPage extends StatefulWidget {
  @override
  _KeyDemoPageState createState() => _KeyDemoPageState();
}

class _KeyDemoPageState extends State<KeyDemoPage> {
  List<Widget> _list = [];

  @override
  void initState() {
    _list = [
      ChangefulContainer(
        key: UniqueKey(),
      ),
      ChangefulContainer(
        key: UniqueKey(),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('key 运用'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            _list.insert(0, _list.removeAt(1));
          });
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: _list,
          ),
        ),
      ),
    );
  }
}

class NormalContainer extends StatelessWidget {
  final Color color = Color.fromRGBO(
      Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: 60,
      height: 60,
    );
  }
}

class ChangefulContainer extends StatefulWidget {
  ChangefulContainer({Key key}) : super(key: key);
  @override
  _ChangefulContainerState createState() => _ChangefulContainerState();
}

class _ChangefulContainerState extends State<ChangefulContainer> {
  final Color color = Color.fromRGBO(
      Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: 60,
      height: 60,
    );
  }
}

class GlobalDemoPage extends StatefulWidget {
  @override
  _GlobalDemoPageState createState() => _GlobalDemoPageState();
}

class _GlobalDemoPageState extends State<GlobalDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('global key运用'),
      ),
      body: GlobalKeyDemo(),
    );
  }
}

class GlobalKeyDemo extends StatefulWidget {
  @override
  _GlobalKeyDemoState createState() => _GlobalKeyDemoState();
}

class _GlobalKeyDemoState extends State<GlobalKeyDemo> {
  GlobalKey<_TextChangeWidgetState> _textKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _textKey.currentState.press(),
            child: Text(
              '点击',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                backgroundColor: Colors.yellow,
              ),
            ),
          ),
          TextChangeWidget(key: _textKey)
        ],
      ),
    );
  }
}

class TextChangeWidget extends StatefulWidget {
  TextChangeWidget({Key key}) : super(key: key);
  @override
  _TextChangeWidgetState createState() => _TextChangeWidgetState();
}

class _TextChangeWidgetState extends State<TextChangeWidget> {
  int _count = 0;
  void press() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(_count.toString()),
    );
  }
}
