import 'dart:async';

import 'package:flutter/material.dart';

class SettingTimerPage extends StatefulWidget {
  @override
  _SettingTimerPageState createState() => _SettingTimerPageState();
}

class _SettingTimerPageState extends State<SettingTimerPage>
    with AutomaticKeepAliveClientMixin {
  int num = 60;
  Timer _timer;

  void startTimer() {
    _timer?.cancel();
    final Duration duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, (Timer timer) {
      num--;
      if (num <= 0) {
        num = 60;
        _timer?.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                if (num == 60) {
                  startTimer();
                }
              },
              child: Text(
                '启动',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                '倒计时${num?.toString()}',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
