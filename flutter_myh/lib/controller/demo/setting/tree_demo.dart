import 'package:flutter/material.dart';

import '../demo_config.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

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
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) => NodeItemWidget(
          node: _list[index],
        ),
        itemCount: _list.length,
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
      ..level = level;
    if (value['Children'] != null) {
      List children = value['Children'];
      children.forEach((obj) {
        model.children.add(NodeModel.jsonToModel(obj, level + 1));
      });
    }
    return model;
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
    );
  }

  Widget _buildItem(NodeModel bean) {
    if (bean.children.isEmpty) {
      return ListTile(
        title: Container(
          padding: EdgeInsets.only(left: (10 + bean.level * 8).toDouble()),
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
      title: Text(bean.nodeName),
      children: bean.children.map<Widget>(_buildItem).toList(),
    );
  }

  _showSeletedName(String name) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("选择的是：" + name)));
  }
}
