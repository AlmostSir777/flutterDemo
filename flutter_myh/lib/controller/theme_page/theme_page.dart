import 'package:flutter/material.dart';
import 'package:flutter_myh/const/config.dart';

import '../../base/app_manager.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  List<ThemeModel> _list;

  @override
  void initState() {
    super.initState();
    _list = List();
    List titles = [
      '红色',
      '蓝色',
      '默认',
    ];
    List colors = [
      Colors.red,
      Colors.green,
      theme_color,
    ];
    for (int i = 0; i < titles.length; i++) {
      ThemeModel model = ThemeModel()
        ..color = colors[i]
        ..title = titles[i];
      _list.add(model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('主题'),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: _list.length,
          itemBuilder: (_, int row) {
            ThemeModel model = _list[row];
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                ThemeData data = ThemeData(
                  primaryColor: model.color,
                );
                AppManager.instance.configTheme(data);
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 49,
                      alignment: Alignment.centerLeft,
                      child: Text(model.title),
                    ),
                    Container(
                      height: 1,
                      color: line_color,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class ThemeModel {
  Color color;
  String title;
}
