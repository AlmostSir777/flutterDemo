import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<FishReduxDemoState> buildEffect() {
  return combineEffects(<Object, Effect<FishReduxDemoState>>{
    FishReduxDemoAction.openDetail: _onAction,
  });
}

void _onAction(Action action, Context<FishReduxDemoState> ctx) {
  print(action.payload);
}
