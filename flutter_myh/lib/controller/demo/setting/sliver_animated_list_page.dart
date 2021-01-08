import 'package:flutter/material.dart';

import '../demo_config.dart';

class SliverAnimatedListPage extends StatefulWidget {
  @override
  _SliverAnimatedListPageState createState() => _SliverAnimatedListPageState();
}

class _SliverAnimatedListPageState extends State<SliverAnimatedListPage> {
  @override
  List<int> _list = [
    1,
    2,
  ];
  var _key = GlobalKey<SliverAnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return BaseNormalContainer(
      title: '动画列表',
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // SliverAnimatedList.of(context);
                  final int _index = _list.length;
                  _list.insert(_index, _index);
                  _key.currentState.insertItem(_index);
                },
              ),
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  final int _index = _list.length - 1;
                  var item = _list[_index].toString();
                  _key.currentState.removeItem(_index,
                      (context, animation) => _buildItem(item, animation));
                  _list.removeAt(_index);
                },
              ),
            ],
          ),
          SliverAnimatedList(
            key: _key,
            initialItemCount: _list.length,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return _buildItem(_list[index].toString(), animation);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String _item, Animation _animation) {
    return SizeTransition(
      sizeFactor: _animation,
      child: Card(
        child: ListTile(
          title: Text(
            _item,
          ),
        ),
      ),
    );
  }
}
