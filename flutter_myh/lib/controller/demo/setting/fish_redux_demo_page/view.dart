import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myh/base/base_container.dart';

import 'action.dart';
import 'state.dart';
import '../redux_demo_page.dart';

Widget buildView(
    FishReduxDemoState state, Dispatch dispatch, ViewService viewService) {
  return BaseNormalContainer(
    title: 'fish_redux练习',
    tailing: IconButton(
      icon: Icon(
        Icons.add,
        size: 30.0,
      ),
      onPressed: () {
        dispatch(FishReduxDemoActionCreator.addItem(ArtcleModel(
          id: state.list.length,
          title: '测试',
          author: 'iOS开发',
        )));
      },
    ),
    body: state.list.length == 0
        ? Center(
            child: Text('暂无数据'),
          )
        : ListView.builder(
            itemCount: state.list.length,
            itemBuilder: (_, int row) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  dispatch(
                      FishReduxDemoActionCreator.openDetail(state.list[row]));
                },
                child: ListTile(
                  subtitle: Text(state.list[row].id.toString()),
                  title: Text(state.list[row].title),
                  leading: Text(state.list[row].author),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => dispatch(
                        FishReduxDemoActionCreator.removeItem(state.list[row])),
                  ),
                ),
              );
            },
          ),
  );
}
