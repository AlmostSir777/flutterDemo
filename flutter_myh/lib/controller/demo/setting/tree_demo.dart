import 'package:flutter/material.dart';

import '../demo_config.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../../../custom/section_list_view.dart';

class TreeDemo extends StatefulWidget {
  @override
  _TreeDemoState createState() => _TreeDemoState();
}

class _TreeDemoState extends State<TreeDemo> {
  List<NodeModel> _list;
  @override
  void initState() {
    _list = [];
    super.initState();
    rootBundle.loadString('lib/assets/file/json/tree.json').then((value) {
      List jsonList = json.decode(value);
      setState(() {
        _list = NodeModel.jsonToData(jsonList);
        print('长度--${_list.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseNormalContainer(
      title: '树形结构',
      body: _list.length == 0
          ? Center(child: Text('加载中...'))
          : SectionListView(
              sectionCount: () => _list.length,
              headerSectionComplete: (_, int section) {
                NodeModel node = _list[section];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      node.isOpen = !node.isOpen;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0),
                    alignment: Alignment.centerLeft,
                    height: 45,
                    child: Text(
                      node.nodeName + node.level.toString(),
                    ),
                  ),
                );
              },
              itemComplete: (_, IndexPath indexPath) {
                return _buildSection(
                    _list[indexPath.section].children[indexPath.row]);
              },
              itemsCount: (int section) {
                print('第${section.toString()}组有' +
                    (_list[section].isOpen ? _list[section].children.length : 0)
                        .toString() +
                    '个元素');
                return _list[section].isOpen
                    ? _list[section].children.length
                    : 0;
              }),
    );
  }

  Widget _buildSection(NodeModel node) {
    return SectionListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      sectionCount: () => 1,
      headerSectionComplete: (_, int section) {
        return GestureDetector(
          onTap: () {
            setState(() {
              node.isOpen = !node.isOpen;
            });
          },
          child: Container(
            padding: EdgeInsets.only(
              left: 10.0 + node.level * 8.0,
            ),
            alignment: Alignment.centerLeft,
            height: 45,
            child: Text(
              node.nodeName + node.level.toString(),
            ),
          ),
        );
      },
      itemComplete: (_, IndexPath indexPath) {
        return _buildSection(node.children[indexPath.row]);
      },
      itemsCount: (int section) => node.isOpen ? node.children.length : 0,
    );
  }
}

class NodeModel {
  int parentNodeId;
  List<NodeModel> children;
  String nodeName;
  int nodeId;
  List nodeValue;
  String orderMeritName;
  int level;
  bool isOpen;
  bool isSelect;
  NodeModel parent;

  // 向下递归赋值
  static nextSelect(NodeModel node, bool isSelect) {
    node.isSelect = isSelect;
    if (node.children.isNotEmpty) {
      node.children.forEach((obj) {
        NodeModel.nextSelect(obj, isSelect);
      });
    }
  }

  //取消选中
  static disSelect(NodeModel node) {
    NodeModel.nextSelect(node, false);
    while (node.level != 0) {
      node.parent.isSelect = false;
      node = node.parent;
    }
  }

  // 选中
  static select(NodeModel node) {
    NodeModel.nextSelect(node, true);
    node = node.parent;
    while (node.level != 0) {
      bool isSelect = true;
      for (NodeModel obj in node.children) {
        if (!obj.isSelect) {
          isSelect = false;
          break;
        }
      }
      if (isSelect) {
        node.isSelect = isSelect;
      } else {
        break;
      }
      node = node.parent;
    }
  }

  // 解析
  static List<NodeModel> jsonToData(List value) {
    List<NodeModel> datas = [];
    value.forEach((obj) {
      datas.add(NodeModel.jsonToModel(obj, 0));
    });
    return datas;
  }

  static NodeModel jsonToModel(Map value, int level) {
    NodeModel model = NodeModel()
      ..parentNodeId = value['ParentNodeId'] as int
      ..nodeName = value['NodeName']
      ..nodeId = value['NodeId'] as int
      ..nodeValue = value['NodeValue']
      ..orderMeritName = value['OrderMeritName']
      ..children = []
      ..level = level
      ..isOpen = false
      ..isSelect = false;
    if (value['Children'] != null) {
      List children = value['Children'];
      children.forEach((obj) {
        NodeModel subModel = NodeModel.jsonToModel(obj, level + 1)
          ..parent = model;
        model.children.add(subModel);
      });
    }
    return model;
  }
}

class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<SliverAnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  SliverAnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(
        index,
        (BuildContext context, Animation<double> animation) =>
            removedItemBuilder(removedItem, context, animation),
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}
