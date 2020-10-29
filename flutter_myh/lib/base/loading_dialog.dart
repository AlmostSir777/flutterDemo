import 'package:flutter/material.dart';

void showLoadingWithText(String loadingMessage, BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => LoadingDialog(text: loadingMessage),
  );
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}

class LoadingDialog extends Dialog {
  final String text;
  LoadingDialog({
    Key key,
    @required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, //透明类型
      child: Center(
        child: SizedBox(
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
                    text,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
