import 'package:fish_redux/fish_redux.dart';
import '../redux_demo_page.dart';

class FishReduxDemoState implements Cloneable<FishReduxDemoState> {
  List<ArtcleModel> list = []; //列表数据
  @override
  FishReduxDemoState clone() {
    return FishReduxDemoState()..list = list;
  }
}

FishReduxDemoState initState(Map<String, dynamic> args) {
  return FishReduxDemoState();
}
