import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<FishReduxDemoState> buildReducer() {
  return asReducer(
    <Object, Reducer<FishReduxDemoState>>{
      FishReduxDemoAction.add: _onAction,
      FishReduxDemoAction.remove: _onAction,
    },
  );
}

FishReduxDemoState _onAction(FishReduxDemoState state, Action action) {
  final FishReduxDemoState newState = state.clone();
  if (action.type == FishReduxDemoAction.add) {
    newState.list.add(action.payload);
  } else if (action.type == FishReduxDemoAction.remove) {
    newState.list.remove(action.payload);
  }
  return newState;
}
