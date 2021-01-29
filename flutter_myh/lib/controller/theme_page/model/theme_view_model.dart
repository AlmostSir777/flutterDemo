import 'package:flutter/material.dart';
import '../../../const/config.dart';

class ThemeViewModel extends ChangeNotifier {
  List<ThemeModel> _list;
  List<ThemeModel> get list => _list;

  List<GlobalKey> keys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  loadData() {
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
    notifyListeners();
  }
}

class ThemeModel {
  Color color;
  String title;
}
