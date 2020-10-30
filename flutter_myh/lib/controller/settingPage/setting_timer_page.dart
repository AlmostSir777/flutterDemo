import 'dart:async';
import 'package:flutter/material.dart';

import '../../base/hud.dart';

class SettingTimerPage extends StatefulWidget {
  @override
  _SettingTimerPageState createState() => _SettingTimerPageState();
}

class _SettingTimerPageState extends State<SettingTimerPage>
    with AutomaticKeepAliveClientMixin {
  int num = 60;
  Timer _timer;

  void _loadCodeNetWork() async {
    showHudWithText(
      text: '获取验证码中...',
      state: HudState.loadingState,
    );
    await Future.delayed(Duration(seconds: 3));
    await hideHud();
    // showHudWithText(text: '发送成功', state: HudState.toastState);
    Toast.toast('发送成功', context: context);
    _startTimer();
  }

  void _startTimer() async {
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
                  _loadCodeNetWork();
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
