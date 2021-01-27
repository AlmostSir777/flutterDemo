import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'package:provider/provider.dart';

import '../demo_config.dart';

class EventBusDemoPage extends StatefulWidget {
  @override
  _EventBusDemoPageState createState() => _EventBusDemoPageState();
}

class _EventBusDemoPageState extends State<EventBusDemoPage> {
  EventModel _eventModel;
  var currentEvent;
  @override
  void initState() {
    super.initState();
    _eventModel = EventModel().._text = '点一点';
    currentEvent = EventModel.eventBus.on<EventModel>().listen((event) {
      _eventModel.reloadText(event.changeStr);
    });
  }

  @override
  void dispose() {
    super.dispose();
    currentEvent?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      title: 'eventBus',
      body: Container(
        child: Center(
          child: GestureDetector(
            onTap: () {
              // eventBus.fire('变变变');
              Navigator.pushNamed(context, SettingPageRoutes.eventBusDetail);
            },
            child: Selector<EventModel, String>(
              builder: (_, text, __) {
                return Text(
                  text,
                  style: TextStyle(
                    color: text_color,
                    fontSize: 16,
                  ),
                );
              },
              selector: (_, viewModel) => viewModel.text,
            ),
          ),
        ),
      ),
      model: _eventModel,
    );
  }
}

class EventBusDetailPage extends StatefulWidget {
  @override
  _EventBusDetailPageState createState() => _EventBusDetailPageState();
}

class _EventBusDetailPageState extends State<EventBusDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BaseNormalContainer(
      title: 'eventBusDetail',
      body: Container(
        child: Center(
            child: GestureDetector(
          onTap: () {
            EventModel.eventBus.fire(EventModel(changeStr: '哈哈哈'));
            Navigator.pop(context);
          },
          child: Container(
            width: 60,
            height: 60,
            color: Colors.red,
          ),
        )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class EventModel extends ChangeNotifier {
  String _text = '点一点';
  String get text => _text;
  static EventBus eventBus = EventBus();
  String changeStr;
  EventModel({this.changeStr});
  reloadText(String text) {
    _text = text;
    notifyListeners();
  }
}
