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

void hideHud() {
  Navigator.pop(navigatorKey.currentState.overlay.context);
}

class MYHHud extends Dialog {
  final String text;
  final HudState state;
  MYHHud({
    Key key,
    @required this.text,
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
    return SizedBox(
      width: 120,
      height: 120,
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                text ?? '',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToastView(BuildContext context) {
    return Center(
        child: Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        minHeight: 10,
        minWidth: 80,
        maxWidth: MediaQuery.of(context).size.width - 60,
        maxHeight: 100,
      ),
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
