import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_myh/controller/demo/setting/redux_demo_page.dart';
import 'action.dart';
import 'state.dart';
import 'package:fluttertoast/fluttertoast.dart';

Effect<FishReduxDemoState> buildEffect() {
  return combineEffects(<Object, Effect<FishReduxDemoState>>{
    Lifecycle.initState: _loadData,
    FishReduxDemoAction.openDetail: _onAction,
  });
}

void _onAction(Action action, Context<FishReduxDemoState> ctx) {
  // todo push otherVc
  print(action.payload);
}

void _loadData(Action action, Context<FishReduxDemoState> ctx) async {
  await Future.delayed(Duration(seconds: 2));
  List<ArtcleModel> _list = List();
  for (int i = 0; i < 10; i++) {
    _list.add(ArtcleModel(
      id: ctx.state.list.length + i,
      title: '测试',
      author: 'iOS开发',
    ));
  }
  Fluttertoast.showToast(
    msg: '数据加载完毕',
    gravity: ToastGravity.CENTER,
  );
  ctx.dispatch(FishReduxDemoActionCreator.loadData(_list));
}
