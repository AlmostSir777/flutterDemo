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
      // body: SingleChildScrollView(
      //   child: ExpansionPanelList(
      //     children: _list.map((node) => _buildExpansionPanel(node)).toList(),
      //     expansionCallback: (int row, bool isExpand) {
      //       NodeModel node = _list[row];
      //       setState(() {
      //         node.isOpen = !node.isOpen;
      //       });
      //     },
      //   ),
      // ),
      body: _list.length == 0
          ? Center(child: Text('加载种...'))
          : SectionListView(
              sectionCount: () => _list.length,
              headerSectionComplete: (_, int section) {
                NodeModel node = _list[section];
              },
              itemComplete: (_, IndexPath indexPath) {
                return _buildSection(
                    _list[indexPath.section].children[indexPath.row]);
              },
              itemsCount: (int section) =>
                  _list[section].isOpen ? _list[section].children.length : 0,
            ),
    );
  }

  Widget _buildSection(NodeModel node) {}

  ExpansionPanelList _buildExpansionPanelList(NodeModel value) {
    return ExpansionPanelList(
      children:
          value.children.map((node) => _buildExpansionPanel(node)).toList(),
      expansionCallback: (int row, bool isExpand) {
        NodeModel node = value.children[row];
        setState(() {
          node.isOpen = !node.isOpen;
        });
      },
    );
  }

  ExpansionPanel _buildExpansionPanel(NodeModel value) {
    return ExpansionPanel(
        isExpanded: value.isOpen,
        headerBuilder: (BuildContext context, bool expand) {
          return Container(
            padding: EdgeInsets.only(
              left: 10 + value.level * 8.0,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              value.nodeName,
              style: TextStyle(
                color: expand ? theme_color : text_color,
                fontSize: value.level == 0 ? 16 : 14,
              ),
            ),
          );
        },
        canTapOnHeader: value.children.isEmpty,
        body: value.children.isEmpty
            ? Container()
            : _buildExpansionPanelList(value));
  }
}

typedef void SelectBlock(NodeModel node);

class NodeItemWidget extends StatelessWidget {
  final NodeModel node;
  final SelectBlock selectBlock;
  NodeItemWidget({
    this.node,
    this.selectBlock,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      color: node.isSelect ? theme_color.withOpacity(0.3) : Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  icon:
                      Icon(node.isOpen ? Icons.lock_open : Icons.lock_outline),
                  onPressed: () {
                    if (selectBlock != null) {
                      selectBlock(node);
                    }
                  }),
              SizedBox(
                width: 10,
              ),
              Text(
                node.nodeName,
                style: TextStyle(color: theme_color, fontSize: 15),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,
            child: Text(
              node.isSelect ? '选中' : '非选中',
              style: TextStyle(
                  color: node.isSelect
                      ? theme_color
                      : Colors.grey.withOpacity(0.4),
                  fontSize: 15),
            ),
          ),
        ],
      ),
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

  static show(NodeModel node) {
    while (node.children.isNotEmpty) {
      node.isSelect = true;
      node.children.forEach((obj) {});
    }
  }

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
        model.children.add(NodeModel.jsonToModel(obj, level + 1));
      });
    }
    return model;
  }
}

class CustomNodeItemWidget extends StatefulWidget {
  final NodeModel node;
  CustomNodeItemWidget({
    this.node,
  });
  @override
  _CustomNodeItemWidgetState createState() => _CustomNodeItemWidgetState();
}

class _CustomNodeItemWidgetState extends State<CustomNodeItemWidget> {
  @override
  Widget build(BuildContext context) {
    return SectionListView(itemComplete: null, itemsCount: null);
  }
}

class NodeItemWidget extends StatefulWidget {
  final NodeModel node;
  NodeItemWidget({
    this.node,
  });
  @override
  _NodeItemWidgetState createState() => _NodeItemWidgetState();
}

class _NodeItemWidgetState extends State<NodeItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: _buildItem(widget.node),
      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
      selected: false,
    );
  }

  Widget _buildItem(NodeModel bean) {
    if (bean.children.isEmpty) {
      return ListTile(
        contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
        selected: false,
        title: Container(
          padding: EdgeInsets.only(left: (20 + bean.level * 8).toDouble()),
          alignment: Alignment.centerLeft,
          child: Text(bean.nodeName),
        ),
        onTap: () {
          _showSeletedName(bean.nodeName);
        },
      );
    }
    return ExpansionTile(
      key: PageStorageKey<NodeModel>(bean),
      title: Container(
        padding: EdgeInsets.only(left: (bean.level * 8).toDouble()),
        alignment: Alignment.centerLeft,
        child: Text(bean.nodeName),
      ),
      children: bean.children.map<Widget>(_buildItem).toList(),
    );
  }

  _showSeletedName(String name) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("选择的是：" + name)));
  }
}
