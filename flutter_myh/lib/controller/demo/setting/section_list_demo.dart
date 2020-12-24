import 'package:flutter/material.dart';
import 'package:flutter_myh/controller/demo/demo_config.dart';
import 'package:provider/provider.dart';

import '../../../custom/section_list_view.dart';

class SectionListDemo extends StatefulWidget {
  @override
  _SectionListDemoState createState() => _SectionListDemoState();
}

class _SectionListDemoState extends State<SectionListDemo> {
  SectionViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = SectionViewModel();
    _viewModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer<SectionViewModel>(
      title: '分组练习',
      body: Selector<SectionViewModel, List<SectionTitle>>(
          builder: (_, items, __) {
            return SectionListView(
              sectionCount: () => items.length,
              headerSectionComplete: (BuildContext context, int row) {
                return Container(
                  height: 30,
                  padding: EdgeInsets.only(left: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(items[row].name),
                );
              },
              itemComplete: (BuildContext context, IndexPath indexPath) {
                return Container(
                  height: 40,
                  padding: EdgeInsets.only(left: 20.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                      items[indexPath.section].items[indexPath.row].itemName),
                );
              },
              itemsCount: (int row) => items[row].items.length,
            );
          },
          selector: (_, viewModel) => viewModel.list),
      model: _viewModel,
    );
  }
}

class SectionViewModel extends ChangeNotifier {
  List<SectionTitle> _list = [];
  List<SectionTitle> get list => _list;
  void loadData() {
    List<SectionTitle> datas = [];
    for (int i = 0; i < 8; i++) {
      SectionTitle section = SectionTitle();
      section.name = '分组${i + 1}';
      section.id = i + 1;
      List<SectionItem> _items = [];
      for (int j = 0; j < 10; j++) {
        SectionItem item = SectionItem();
        item.itemName = '子元素${j + 1}';
        item.itemId = j + 1;
        _items.add(item);
      }
      section.items = _items;
      datas.add(section);
    }
    _list = datas;
    notifyListeners();
  }
}

class SectionTitle {
  String name;
  int id;
  List<SectionItem> items;
}

class SectionItem {
  String itemName;
  int itemId;
}
