import 'package:flutter/material.dart';

class TimeCountModel extends ChangeNotifier {
  int _timeCount = 0;
  int get timeCount => _timeCount;

  void timeAdd() {
    _timeCount++;
    notifyListeners();
  }
}

class BannerModel {
  String imgUrl;
  String title;
}

class BannerViewModel extends ChangeNotifier {
  List<BannerModel> _list = [];
  List<BannerModel> get list => _list;

  // set list(List<BannerModel> value) {
  //   _list = value;
  //   notifyListeners();
  // }

  Future<void> loadData() async {
    await Future.delayed(Duration(seconds: 1));
    List<String> titles = ['测试', '练习', '开心玩', '6666'];
    List<String> avatarArr = [
      'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2319772070,3114389419&fm=26&gp=0.jpg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601197789533&di=f7acc1820e1094c9bbef458f93cd82b4&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201411%2F01%2F20141101171342_xHRH2.jpeg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601197789532&di=8bb423fa11efc97d89ba571fa0008d16&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201410%2F09%2F20141009224754_AswrQ.jpeg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601197789532&di=f96c5afe1f5b32671ecd9164cbaa52a3&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ff331c6a4056b8fc7766941647aa3534927ce0005c5c5-b9WRQf_fw658',
    ];
    List<BannerModel> _bannerList = [];
    for (int i = 0; i < avatarArr.length; i++) {
      BannerModel model = BannerModel()
        ..imgUrl = avatarArr[i]
        ..title = titles[i];
      _bannerList.add(model);
    }
    _list = _bannerList;
    notifyListeners();
  }
}
