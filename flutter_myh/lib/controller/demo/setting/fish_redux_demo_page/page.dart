import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'keep_alive_widget.dart';

class FishReduxDemoPage extends Page<FishReduxDemoState, Map<String, dynamic>> {
  FishReduxDemoPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<FishReduxDemoState>(
              adapter: null, slots: <String, Dependent<FishReduxDemoState>>{}),
          middleware: <Middleware<FishReduxDemoState>>[],
          wrapper: keepAliveWrapper,
        );
}
