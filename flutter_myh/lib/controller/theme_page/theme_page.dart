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
      '默认',
      '红色',
      '蓝色',
    ];
    List colors = [
      theme_color,
      Colors.red,
      Colors.green,
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
            bool isSelect = AppManager().themeData.primaryColor == model.color;
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(model.title),
                          isSelect ? Icon(Icons.select_all) : Container(),
                        ],
                      ),
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
