import 'package:flutter/material.dart';

import 'config.dart';

enum HudState {
  loadingState,
  toastState,
}
void showHudWithText({
  String text,
  HudState state,
}) {
  showDialog(
    context: navigatorKey.currentState.overlay.context,
    barrierDismissible: false,
    builder: (_) => MYHHud(
      text: text,
      state: state,
    ),
  );
  if (state == HudState.toastState) {
    Future.delayed(Duration(seconds: 2), () {
      hideHud();
    });
  }
}

Future<void> hideHud() async {
  Navigator.pop(navigatorKey.currentState.overlay.context);
}

class MYHHud extends Dialog {
  final String text;
  final HudState state;
  MYHHud({
    Key key,
    this.text,
    this.state = HudState.loadingState,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, //透明类型
      child: Center(
        child: state == HudState.loadingState
            ? _buildLoadingView()
            : _buildToastView(context),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      child: text != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    text ?? '',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
    );
  }

  Widget _buildToastView(BuildContext context) {
    return Center(
        child: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff25272c),
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ));
  }
}

class Toast {
  static OverlayEntry _overlayEntry; //toast靠它添加到屏幕
  static bool _showing = false; // toast是否正在showing
  static DateTime _startTime; //开启一个新toast的当前时间，用于对比时间
  static String _msg;
  static BuildContext _context;
  static void toast(
    String msg, {
    BuildContext context,
  }) async {
    assert(msg != null);
    _msg = msg;
    _context = context;
    _startTime = DateTime.now();
    // 获取overlayState
    OverlayState overlayState = Overlay.of(_context);
    _showing = true;
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(builder: (BuildContext context) {
        return Center(
          child: Container(
            alignment: Alignment.center,
            child: AnimatedOpacity(
              opacity: _showing ? 1.0 : 0.0,
              duration: _showing
                  ? Duration(milliseconds: 100)
                  : Duration(microseconds: 400),
              child: _buildToastWidget(),
            ),
          ),
        );
      });
      overlayState.insert(_overlayEntry);
    } else {
      // 重新绘制
      _overlayEntry.markNeedsBuild();
    }
    await Future.delayed(Duration(milliseconds: 2000)); //等待两秒
    if (DateTime.now().difference(_startTime).inMilliseconds >= 2000) {
      _showing = false;
      _overlayEntry.markNeedsBuild();
    }
  }

//toast绘制
  static _buildToastWidget() {
    return Center(
      child: Card(
        color: Colors.black26,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Text(
            _msg,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
