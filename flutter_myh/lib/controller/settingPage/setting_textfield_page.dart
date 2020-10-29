import 'package:flutter/material.dart';

import '../../base/message_dialog.dart';

class SettingTextFieldPage extends StatefulWidget {
  @override
  _SettingTextFieldPageState createState() => _SettingTextFieldPageState();
}

class _SettingTextFieldPageState extends State<SettingTextFieldPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: TextFieldDemoView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TextFieldDemoView extends StatefulWidget {
  final String content;
  TextFieldDemoView({this.content});
  @override
  _TextFieldDemoViewState createState() => _TextFieldDemoViewState();
}

class _TextFieldDemoViewState extends State<TextFieldDemoView>
    with WidgetsBindingObserver {
  TextEditingController _editingController;
  FocusNode _focusNode;
  @override
  void initState() {
    _focusNode = FocusNode();
    _editingController = TextEditingController.fromValue(TextEditingValue(
      text: widget?.content ?? '请输入文本',
      selection: TextSelection.fromPosition(TextPosition(
          offset: (widget?.content ?? '请输入文本').length,
          affinity: TextAffinity.downstream)),
    ));
    _editingController.addListener(() {
      print(_editingController.text);
    });
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
    WidgetsBinding.instance.addObserver(this);
    print('initState');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state.toString());
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(TextFieldDemoView oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _editingController?.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: 300,
          height: 400,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Container(
              color: Colors.red,
              child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.white,
                ),
                focusNode: _focusNode,
                controller: _editingController,
                decoration: InputDecoration(border: InputBorder.none),
                maxLines: 40,
                onChanged: (String value) {
                  print(value);
                  if (_editingController.text.length > 10) {
                    showMessage(
                      title: '提示',
                      content:
                          '内容不能超过10个字dsakdasdkasjkdjasjdjkasldjasjkdjkasjkdjkasjkdjkasjkdsaj',
                      callBackEvent: (MessageCallBackState state) {
                        print(
                            state == MessageCallBackState.MessageCallBackConfirm
                                ? '点击了确定'
                                : '点击了取消');
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void reassemble() {
    print('reassemble');
    super.reassemble();
  }

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }
}
