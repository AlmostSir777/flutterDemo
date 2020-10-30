import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectView extends StatefulWidget {
  @override
  _SubjectViewState createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  SubjectListModel viewModel;
  @override
  void initState() {
    _getSomeData();
    super.initState();
  }

  void _getSomeData() {
    viewModel = SubjectListModel();
    List titles = ['数学', '语文', '英语'];
    List<SubjectModel> list = [];
    for (String item in titles) {
      SubjectModel model = SubjectModel(name: item, isSelect: false);
      list.add(model);
    }
    viewModel.addList(list);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SubjectListModel>(
      create: (_) => viewModel,
      builder: (_, __) {
        return Container(
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
        );
      },
    );
  }
}

class SubjectTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0),
            child: Text(
              '学科筛选：${context.watch<SubjectListModel>().list.length}个学科，${context.watch<SubjectListModel>().selectList.length}个被选学科',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          Consumer<SubjectListModel>(builder: (_, viewModel, __) {
            return Container(
              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
              child: Text(
                '学科筛选：${viewModel.list.length}个学科，${viewModel.selectList.length}个被选学科',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            );
          }),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  List titles = ['化学', '生物', '历史'];
                  List<SubjectModel> list = [];
                  for (String item in titles) {
                    SubjectModel model =
                        SubjectModel(name: item, isSelect: false);
                    list.add(model);
                  }
                  context.read<SubjectListModel>().addList(list);
                },
                child: _buildButton(SubjectModel(name: '全部学科')),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15, left: 10),
            child: Container(
              color: Colors.grey,
              height: 0.4,
              width: MediaQuery.of(context).size.width - 20,
            ),
          ),
        ],
      ),
    );
  }
}

class SubjectSectionView extends StatelessWidget {
  final List<SubjectModel> list;
  SubjectSectionView({
    @required this.list,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
      ),
      alignment: Alignment.center,
      child: GridView.builder(
          itemCount: list.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 8 / 3.0,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int row) {
            return Selector<SubjectListModel, List<SubjectModel>>(
                builder: (_, selectList, __) {
                  return GestureDetector(
                    onTap: () => context
                        .read<SubjectListModel>()
                        .changeModelState(list[row]),
                    child: _buildButton(list[row]),
                  );
                },
                selector: (_, viewModel) => viewModel.selectList);
          }),
    );
  }
}

Widget _buildButton(SubjectModel model) {
  return Container(
    alignment: Alignment(0, 0),
    height: 30,
    width: 80,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      border: Border.all(
          width: 1,
          color: model?.isSelect ?? false ? Color(0xff4782f6) : Colors.black),
    ),
    child: Text(
      model.name,
      style: TextStyle(
        fontSize: 14,
        color: model?.isSelect ?? false ? Color(0xff4782f6) : Colors.black,
      ),
    ),
  );
}

class SubjectModel extends Object {
  String name;
  bool isSelect = false;
  SubjectModel({
    this.name,
    this.isSelect,
  });
}

class SubjectListModel extends ChangeNotifier {
  List<SubjectModel> _list = [];
  List<SubjectModel> get list => _list;

  List<SubjectModel> _selectList = [];
  List<SubjectModel> get selectList => _selectList;

  void addList(List<SubjectModel> value) {
    List<SubjectModel> list = [];
    list.addAll(_list);
    list.addAll(value);
    _list = list;
    notifyListeners();
  }

  void changeModelState(SubjectModel model) {
    model.isSelect = model.isSelect == true ? false : true;
    List<SubjectModel> list = [];
    list.addAll(_selectList);
    if (model.isSelect) {
      list.add(model);
    } else {
      list.remove(model);
    }
    _selectList = list;
    notifyListeners();
  }
}
