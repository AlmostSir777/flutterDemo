import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class CommonUtil {
  static void initScreen(BuildContext context) {
    if (ScreenUtil.screenWidth == null || ScreenUtil.screenWidth == 0) {
      ScreenUtil.init(context, width: 750, height: 1334);
    }
  }

  static double scaleWidth(value) {
    // return value / 2.0;
    return ScreenUtil().setWidth(value);
  }

  static double scaleHeight(value) {
    // return value / 2.0;
    return ScreenUtil().setHeight(value);
  }

  /// 底部安全距离
  static double get bottomBarHeight => ScreenUtil.bottomBarHeight;

  /// 屏幕宽度
  static double get screenWidth => ScreenUtil.screenWidth;

  /// 屏幕高度
  static double get screenHeight => ScreenUtil.screenHeight;

  /// 状态栏高度
  static double get statusBarHeight => ScreenUtil.statusBarHeight;

  /// 导航栏+状态栏
  static double get navHeight {
    double navBarHeight = Platform.isIOS ? 44.0 : 50.0;
    return CommonUtil.statusBarHeight + navBarHeight;
  }

  /// 内容区域高度，除掉 appbar + 状态栏 高度
  static double get screenContentHeight =>
      ScreenUtil.screenHeight - CommonUtil.navHeight;

  //UI定义的间隔距离
  static double get normalPadding => scaleWidth(25);

  /// 随机色
  static Color randomColor() {
    return Color.fromARGB(
      255,
      Random().nextInt(256) + 0,
      Random().nextInt(256) + 0,
      Random().nextInt(256) + 0,
    );
  }

  static dynamic decode(source) {
    if (source != null) return jsonDecode(source) ?? null;
    return null;
  }

  static String encode(value) {
    return value != null ? jsonEncode(value) : null;
  }
}
