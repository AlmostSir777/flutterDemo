import 'package:flutter/material.dart';
import 'package:flutter_myh/base/common_util.dart';
import 'package:flutter_myh/const/config.dart';
import 'package:provider/provider.dart';

import '../../base/base_container.dart';
import '../../base/app_manager.dart';
import './model/theme_view_model.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  ThemeViewModel _viewModel;
  ScrollController _scrollController;
  @override
  void initState() {
    _viewModel = ThemeViewModel();
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        RenderBox renderBox =
            _viewModel.keys.first.currentContext.findRenderObject();
        var offset = renderBox.localToGlobal(Offset.zero);
        print(offset.dy - CommonUtil.navHeight - 10);
      });
    _viewModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer<ThemeViewModel>(
        isRootPage: true,
        title: '主题设置',
        body: Consumer<ThemeViewModel>(
          builder: (_, viewModel, __) {
            return ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(10),
              itemCount: viewModel.list.length,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (_, int row) {
                ThemeModel model = viewModel.list[row];
                bool isSelect =
                    AppManager().themeData.primaryColor == model.color;
                return GestureDetector(
                  key: _viewModel.keys[row],
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    AppManager.instance.configThemeWithBarColor(model.color);
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 49,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(model.title),
                              isSelect ? Icon(Icons.select_all) : Container(),
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: line_color,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        model: _viewModel);
  }
}
