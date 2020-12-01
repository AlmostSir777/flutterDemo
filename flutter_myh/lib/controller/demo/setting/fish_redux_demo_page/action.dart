import 'package:fish_redux/fish_redux.dart';

import '../redux_demo_page.dart';

enum FishReduxDemoAction {
  add,
  remove,
  openDetail,
  loadData,
}

class FishReduxDemoActionCreator {
  static Action addItem(ArtcleModel item) {
    return Action(FishReduxDemoAction.add, payload: item);
  }

  static Action removeItem(ArtcleModel item) {
    return Action(FishReduxDemoAction.remove, payload: item);
  }

  static Action openDetail(ArtcleModel item) {
    return Action(FishReduxDemoAction.openDetail, payload: item);
  }

  static Action loadData(List<ArtcleModel> items) {
    return Action(FishReduxDemoAction.loadData, payload: items);
  }
}
