import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../demo_config.dart';
import '../../../base/sqlite/db_manager.dart';

class SqliteDemoPage extends StatefulWidget {
  @override
  _SqliteDemoPageState createState() => _SqliteDemoPageState();
}

class _SqliteDemoPageState extends State<SqliteDemoPage> {
  SqliteViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SqliteViewModel();
    _viewModel.init();
  }

  @override
  void dispose() {
    DbManager.instance().closeDb();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
        title: 'sqlite练习',
        tailing: GestureDetector(
          onTap: () {
            _viewModel.insertUserInfo();
          },
          child: Icon(Icons.add),
        ),
        body: Selector<SqliteViewModel, List<UserInfoModel>>(
          builder: (_, list, __) {
            if (list == null) return Container();
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, int row) {
                  return _buildItem(list[row]);
                });
          },
          selector: (_, viewModel) => viewModel.list,
        ),
        model: _viewModel);
  }

  Widget _buildItem(UserInfoModel infoModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          height: 49,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: infoModel.headImgUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
              Text(infoModel.nickName),
              Text(infoModel.phone),
            ],
          ),
        ),
        Container(
          color: line_color,
          width: CommonUtil.screenWidth,
          height: 0.5,
        ),
      ],
    );
  }
}

class SqliteViewModel extends ChangeNotifier {
  List<UserInfoModel> _list;
  List<UserInfoModel> get list => _list;

  init() async {
    await DbManager.instance().openDb(DbManager.UserInfoTable);
    loadData();
  }

  loadData() async {
    _list =
        await DbManager.instance().queryItems<UserInfoModel>(UserInfoModel());
    notifyListeners();
  }

  /*
  List<String> titles = ['测试', '练习', '开心玩', '6666'];
    List<String> avatarArr = [
      'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2319772070,3114389419&fm=26&gp=0.jpg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601197789533&di=f7acc1820e1094c9bbef458f93cd82b4&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201411%2F01%2F20141101171342_xHRH2.jpeg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601197789532&di=8bb423fa11efc97d89ba571fa0008d16&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201410%2F09%2F20141009224754_AswrQ.jpeg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601197789532&di=f96c5afe1f5b32671ecd9164cbaa52a3&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ff331c6a4056b8fc7766941647aa3534927ce0005c5c5-b9WRQf_fw658',
    ];
  */
  insertUserInfo() async {
    UserInfoModel userInfo = UserInfoModel()
      ..userId = '${Random().nextInt(999999999)}'
      ..nickName = '小红'
      ..headImgUrl =
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601197789533&di=f7acc1820e1094c9bbef458f93cd82b4&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201411%2F01%2F20141101171342_xHRH2.jpeg'
      ..phone = '18679859829';
    await DbManager.dbManager.insertItem<UserInfoModel>(userInfo);
    await loadData();
  }
}

class UserInfoModel extends DbBaseBean {
  String userId;
  String nickName;
  String headImgUrl;
  String phone;

  @override
  DbBaseBean fromJson(Map<String, dynamic> map) {
    UserInfoModel model = UserInfoModel()
      ..userId = map['userId']
      ..nickName = map['nickName']
      ..headImgUrl = map['headImgUrl']
      ..phone = map['phone'];
    return model;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['userId'] = userId ?? '';
    map['nickName'] = nickName ?? '';
    map['headImgUrl'] = headImgUrl ?? '';
    map['phone'] = phone ?? '';
    return map;
  }

  @override
  String getTableName() {
    return DbManager.UserInfoTable;
  }
}
