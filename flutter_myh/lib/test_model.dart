import 'package:flutter/material.dart';

class IconModel extends Object {
  IconData icon;
  String name;
  IconModel(
    this.icon,
    this.name,
  );
}

class ListModel extends Object {
  int index;
  String name;
  String avatar;
  ListModel(
    this.index,
    this.name,
    this.avatar,
  );
}

class TabbarSelectModel with ChangeNotifier {
  int _index;
  int get index => _index;
  TabbarSelectModel() {
    this._index = 0;
  }
  void changeTabbarIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
