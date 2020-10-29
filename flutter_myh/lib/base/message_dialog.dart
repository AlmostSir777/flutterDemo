import 'package:flutter/material.dart';

import './config.dart';

enum MessageCallBackState {
  MessageCallBackConfirm,
  MessageCallBackCancel,
}

typedef void CallBackEvent(MessageCallBackState state);

void showMessage({
  String title,
  String content,
  CallBackEvent callBackEvent,
}) {
  showDialog(
    context: navigatorKey.currentState.overlay.context,
    barrierDismissible: false,
    builder: (context) => MessageDialog(
      title: title,
      content: content,
      callBackEvent: callBackEvent,
    ),
  );
}

class MessageDialog extends Dialog {
  final String title;
  final String content;
  final CallBackEvent callBackEvent;

  MessageDialog({Key key, this.title, this.content, this.callBackEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.0),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildTitle(),
              _buildCenter(),
              _buildBottom(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      child: Text(
        title ?? '提示',
        style: TextStyle(
          color: Color(0xff25272c),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCenter() {
    return Container(
      padding: EdgeInsets.only(
        top: 20.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Text(
        content ?? '',
        style: TextStyle(
          color: Color(0xff25272c),
          fontSize: 16,
        ),
        maxLines: 10,
      ),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 30.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Color(0xffaaaaaa),
            height: 0.5,
          ),
          Container(
            height: 49.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (callBackEvent != null) {
                      callBackEvent(MessageCallBackState.MessageCallBackCancel);
                    }
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 80,
                    height: 40,
                    child: Text(
                      '取消',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff4782f6),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Color(0xffaaaaaa),
                  width: 0.5,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (callBackEvent != null) {
                      callBackEvent(
                          MessageCallBackState.MessageCallBackConfirm);
                    }
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 80,
                    height: 40,
                    child: Text(
                      '确定',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff4782f6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
