import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../../base/base_container.dart';
import 'subject_show.dart';

class SubjectPage extends StatefulWidget {
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  SubjectListModel _viewModel;
  @override
  void initState() {
    super.initState();
    _getSomeData();
  }

  void _getSomeData() {
    _viewModel = SubjectListModel();
    List titles = ['数学', '语文', '英语'];
    List<SubjectModel> list = [];
    for (String item in titles) {
      SubjectModel model = SubjectModel(name: item, isSelect: false);
      list.add(model);
    }
    _viewModel.addList(list);
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer<SubjectListModel>(
      title: '状态管理',
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SubjectTop(),
            Selector<SubjectListModel, List<SubjectModel>>(
                builder: (_, list, __) {
                  return SubjectSectionView(
                    list: list,
                  );
                },
                selector: (_, viewModel) => viewModel.list),
          ],
        ),
      ),
      model: _viewModel,
    );
  }
}
