import 'package:flutter/material.dart';

import '../demo/simple_widget_demo.dart';
import '../demo/page_view_demo_page.dart';
import '../demo/gesture_demo_page.dart';
import '../demo/refresh_demo_page.dart';
import '../demo/picker_demo_page.dart';

class SettingSampleDemoPage extends StatefulWidget {
  @override
  _SettingSampleDemoPageState createState() => _SettingSampleDemoPageState();
}

class _SettingSampleDemoPageState extends State<SettingSampleDemoPage>
    with AutomaticKeepAliveClientMixin {
  List<String> _list;
  @override
  void initState() {
    _list = [
      'ConstrainedBox 运用',
      'pageView 运用',
      '手势运用',
      '刷新组件',
      '底部弹窗',
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 10,
      ),
      child: Center(
        child: ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, int row) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (row == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return SampleWidgetDemoPage();
                      }),
                    );
                  } else if (row == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return PageViewDemoPage();
                      }),
                    );
                  } else if (row == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return GestureDemoPage();
                      }),
                    );
                  } else if (row == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return RefreshDemoPage();
                      }),
                    );
                  } else if (row == 4) {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return PickerTimeView(
                            doneCallBack: (String value) {
                              print(value);
                              Navigator.of(context).pop();
                            },
                            cancelCallBack: () => Navigator.of(context).pop(),
                          );
                        });
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _list[row],
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xffaaaaaa),
                      height: 0.5,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
