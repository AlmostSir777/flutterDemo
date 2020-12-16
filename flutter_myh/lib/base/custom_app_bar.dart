import 'dart:io';
import 'package:flutter/material.dart';
import 'common_util.dart';
import 'app_manager.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget leading;
  final Widget tailing;
  final Color navColor;
  final VoidCallback callBack;
  final bool isRootPage;
  final bool showNav;
  CustomAppBar({
    this.title,
    this.leading,
    this.tailing,
    this.navColor,
    this.callBack,
    this.isRootPage,
    this.showNav = true,
  });
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
  @override
  Size get preferredSize => showNav ?? true
      ? Size.fromHeight(Platform.isIOS ? 44.0 : 50.0)
      : Size.zero;
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    double _height = Platform.isIOS ? 44.0 : 50.0;
    return widget.showNav
        ? Container(
            color:
                widget.navColor ?? AppManager.instance.themeData.primaryColor,
            padding: EdgeInsets.only(top: CommonUtil.statusBarHeight),
            child: Container(
              width: CommonUtil.screenWidth,
              height: _height,
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
              ),
              child: Stack(
                fit: StackFit.loose,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      widget.isRootPage
                          ? Container()
                          : GestureDetector(
                              child: widget.leading ??
                                  Image.asset(
                                      'lib/assets/images/nav_back_white.png'),
                              onTap: () {
                                if (widget.callBack != null) {
                                  widget.callBack();
                                } else {
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                      widget.tailing ?? Container(),
                    ],
                  ),
                  Center(
                      child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 10,
                      maxWidth: CommonUtil.scaleWidth(400),
                    ),
                    child: widget.title ?? Container(),
                  )),
                ],
              ),
            ),
          )
        : Container();
  }
}

/*

Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            widget.isRootPage
                ? Container()
                : GestureDetector(
                    child: widget.leading ??
                        Image.asset('lib/assets/images/nav_back_white.png'),
                    onTap: () {
                      if (widget.callBack != null) {
                        widget.callBack();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
            widget.title ?? Container(),
            widget.tailing ?? Container(),
          ],
        )

*/
