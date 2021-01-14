import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

import '../demo_config.dart';

class EventBusDemoPage extends StatefulWidget {
  @override
  _EventBusDemoPageState createState() => _EventBusDemoPageState();
}

class _EventBusDemoPageState extends State<EventBusDemoPage> {
  String changeStr;
  var currentEvent;
  @override
  void initState() {
    super.initState();
    changeStr = '点一点';
    currentEvent = EventModel.eventBus.on<EventModel>().listen((event) {
      setState(() {
        changeStr = event.changeStr;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    currentEvent?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BaseNormalContainer(
      title: 'eventBus',
      body: Container(
        child: Center(
          child: GestureDetector(
            onTap: () {
              // eventBus.fire('变变变');
              Navigator.pushNamed(context, SettingPageRoutes.eventBusDetail);
            },
            child: Text(
              changeStr,
              style: TextStyle(
                color: text_color,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
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

class EventModel {
  static EventBus eventBus = EventBus();
  String changeStr;
  EventModel({this.changeStr});
}
