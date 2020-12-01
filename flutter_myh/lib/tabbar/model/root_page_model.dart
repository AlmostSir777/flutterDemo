import 'package:flutter/material.dart';

class IconModel extends Object {
  IconData icon;
  String name;
  IconModel(
    this.icon,
    this.name,
  );
}

class HomeViewModel extends ChangeNotifier {
  int _starNum;
  int get starNum => _starNum;
  List<ListModel> _listModels;
  List<ListModel> get listModels => _listModels;
  void loadData() {
    List<ListModel> _list = [];
    List avatarArr = [
      'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2319772070,3114389419&fm=26&gp=0.jpg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601197789533&di=f7acc1820e1094c9bbef458f93cd82b4&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201411%2F01%2F20141101171342_xHRH2.jpeg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601197789532&di=8bb423fa11efc97d89ba571fa0008d16&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201410%2F09%2F20141009224754_AswrQ.jpeg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601197789532&di=f96c5afe1f5b32671ecd9164cbaa52a3&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ff331c6a4056b8fc7766941647aa3534927ce0005c5c5-b9WRQf_fw658',
    ];
    List titleArr = [
      '传值以及回调',
      'provider状态管理',
      'padding-align-center运用',
      '发布页面'
    ];
    for (int i = 0; i < titleArr.length; i++) {
      ListModel model = ListModel(i, titleArr[i], avatarArr[i]);
      _list.add(model);
    }
    _listModels = _list;

    _starNum = 10;

    notifyListeners();
  }

  addNum() {
    int num = _starNum + 1;
    _starNum = num;
    notifyListeners();
  }
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
