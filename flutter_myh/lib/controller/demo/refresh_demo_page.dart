import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../base/hud.dart';

class RefreshDemoPage extends StatefulWidget {
  @override
  _RefreshDemoPageState createState() => _RefreshDemoPageState();
}

class _RefreshDemoPageState extends State<RefreshDemoPage> {
  EasyRefreshController _controller;
  List<int> _list;

  @override
  void initState() {
    _loadDefaultData();
    _controller = EasyRefreshController();
    super.initState();
  }

  void _loadDefaultData() {
    _list = [1, 2, 3, 4];
  }

  Future<void> _getData(bool isLoadMore) async {
    await Future.delayed(Duration(seconds: 3), () {
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
    });
    Toast.toast(
      isLoadMore ? '获取数据成功' : '刷新数据成功',
      context: context,
    );
    isLoadMore ? _controller.finishLoad() : _controller.finishRefresh();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('easyrefresh运用'),
      ),
      body: SafeArea(
        child: _buildSampleDemo(),
      ),
    );
  }

// 基础
  Widget _buildSampleDemo() {
    return EasyRefresh(
      controller: _controller,
      enableControlFinishLoad: true,
      enableControlFinishRefresh: true,
      child: ListView.builder(
        padding: EdgeInsets.only(
          top: 10,
        ),
        itemBuilder: (_, int row) {
          return Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: Text('第${_list[row]}行'),
          );
        },
        itemCount: _list.length,
      ),
      onLoad: () async {
        _getData(true);
      },
      onRefresh: () async {
        _getData(false);
      },
    );
  }

  Widget _buildCustomRefresh(BuildContext context) {
    return EasyRefresh.custom(
      enableControlFinishLoad: true,
      enableControlFinishRefresh: true,
      controller: _controller,
      header: ClassicalHeader(),
      footer: ClassicalFooter(
        safeArea: true,
        overScroll: true,
      ),
      onRefresh: () => _getData(false),
      onLoad: () => _getData(true),
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, int row) {
              return Container(
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
