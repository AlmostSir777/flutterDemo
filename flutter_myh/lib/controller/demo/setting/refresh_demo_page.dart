import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../../base/hud.dart';
import '../../../base/base_container.dart';

class RefreshDemoPage extends StatefulWidget {
  @override
  _RefreshDemoPageState createState() => _RefreshDemoPageState();
}

class _RefreshDemoPageState extends State<RefreshDemoPage> {
  EasyRefreshController _controller;
  List<int> _list;
  RefreshListModel _listModel;

  @override
  void initState() {
    _loadDefaultData();
    _controller = EasyRefreshController();
    super.initState();
  }

  void _loadDefaultData() {
    _list = [1, 2, 3, 4];
    _listModel = RefreshListModel([1, 2, 3, 4]);
  }

  Future<void> _getData(bool isLoadMore) async {
    Future.delayed(Duration(seconds: 3), () {
      if (isLoadMore) {
        int currentLength = _list.length;
        List<int> addList = [];
        for (int i = 1; i <= 10; i++) {
          addList.add(i + currentLength);
        }
        setState(() {
          _list.addAll(addList);
        });
      } else {
        _list.clear();
        setState(() {
          _list = [1, 2, 3, 4];
        });
      }
      isLoadMore ? _controller.finishLoad() : _controller.finishRefresh();
      Toast.toast(
        isLoadMore ? '获取数据成功' : '刷新数据成功',
        context: context,
      );
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      title: 'easyrefresh运用',
      body: SafeArea(
        child: Selector<RefreshListModel, List<int>>(
            builder: (_, list, __) => buildSampleDemo(context, list),
            selector: (_, listModel) => listModel.list),
      ),
      model: _listModel,
    );
  }

// 基础
  Widget buildSampleDemo(BuildContext context, List<int> list) {
    return EasyRefresh.custom(
      footer: ClassicalFooter(
        safeArea: true,
      ),
      controller: _controller,
      enableControlFinishLoad: true,
      enableControlFinishRefresh: false,
      slivers: <Widget>[
        SliverFixedExtentList(
          itemExtent: 40,
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                height: 49,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  left: 10,
                ),
                child: Text('第${list[index]}行'),
              );
            },
            childCount: list.length,
          ),
        ),
      ],
      onLoad: () async {
        await _listModel.getData(true);
        _controller.finishLoad(noMore: _listModel.list.length >= 40);
      },
      onRefresh: () async {
        await _listModel.getData(false);
        _controller.resetLoadState();
        _controller.finishRefresh();
      },
    );
  }

  Widget buildCustomRefresh(BuildContext context) {
    return EasyRefresh.custom(
      enableControlFinishLoad: true,
      enableControlFinishRefresh: true,
      controller: _controller,
      header: ClassicalHeader(),
      footer: ClassicalFooter(),
      onRefresh: () => _getData(false),
      onLoad: () => _getData(true),
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, int row) {
              return Container(
                height: 49,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  left: 10,
                ),
                child: Text('第${_list[row]}行'),
              );
            },
            childCount: _list.length,
          ),
        ),
      ],
    );
  }
}

class RefreshListModel extends ChangeNotifier {
  List<int> _list;
  List<int> get list => _list;
  set list(List<int> value) {
    _list = value;
    notifyListeners();
  }

  RefreshListModel(this._list) {
    if (_list == null) {
      _list = [1, 2, 3, 4];
    }
  }
  void addListValue(List<int> value) {
    List<int> list = [];
    list.addAll(_list);
    list.addAll(value);
    this.list = list;
  }

  Future<void> getData(bool isLoadMore) async {
    await Future.delayed(Duration(seconds: 3));
    if (isLoadMore) {
      int currentLength = _list.length;
      List<int> addList = [];
      for (int i = 1; i <= 10; i++) {
        addList.add(i + currentLength);
      }
      addListValue(addList);
    } else {
      this.list = [1, 2, 3, 4];
    }
  }
}
