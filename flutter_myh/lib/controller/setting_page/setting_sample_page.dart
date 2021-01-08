import 'package:flutter/material.dart';

import 'setting_page_routes.dart';
import '../demo/setting/picker_demo_page.dart';

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
      '绘制',
      'key相关',
      'global key 运用',
      'provider多个viewModel运用',
      '图片选择器',
      '视频播放器',
      '裁剪',
      'flutter_redux练习',
      'fish_redux练习',
      '分组练习',
      '树结构',
      '动态列表',
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
                onTap: () => _gotoVc(row),
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

  void _gotoVc(int row) {
    if (row == 0) {
      Navigator.pushNamed(context, SettingPageRoutes.simpleWidget);
    } else if (row == 1) {
      Navigator.pushNamed(context, SettingPageRoutes.pageview);
    } else if (row == 2) {
      Navigator.pushNamed(context, SettingPageRoutes.gesture);
    } else if (row == 3) {
      Navigator.pushNamed(context, SettingPageRoutes.refresh);
    } else if (row == 4) {
      showModalBottomSheet(
          isDismissible: false,
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
    } else if (row == 5) {
      Navigator.pushNamed(context, SettingPageRoutes.cavas);
    } else if (row == 6) {
      Navigator.pushNamed(context, SettingPageRoutes.key);
    } else if (row == 7) {
      Navigator.pushNamed(context, SettingPageRoutes.gloabKey);
    } else if (row == 8) {
      Navigator.pushNamed(context, SettingPageRoutes.provider);
    } else if (row == 9) {
      Navigator.pushNamed(context, SettingPageRoutes.imagePicker);
    } else if (row == 10) {
      Navigator.pushNamed(context, SettingPageRoutes.videoPlayer);
    } else if (row == 11) {
      Navigator.pushNamed(context, SettingPageRoutes.clip);
    } else if (row == 12) {
      Navigator.pushNamed(context, SettingPageRoutes.redux);
    } else if (row == 13) {
      Navigator.pushNamed(context, SettingPageRoutes.fishRedux);
    } else if (row == 14) {
      Navigator.pushNamed(context, SettingPageRoutes.secctionListView);
    } else if (row == 15) {
      Navigator.pushNamed(context, SettingPageRoutes.treeListView);
    } else if (row == 16) {
      Navigator.pushNamed(context, SettingPageRoutes.sliverAnimationed);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
