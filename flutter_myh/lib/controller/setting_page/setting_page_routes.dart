import 'package:flutter/material.dart';
import 'package:flutter_myh/controller/demo/setting/refresh_demo_page.dart';

import 'setting_config.dart';

class SettingPageRoutes {
  static String settingRoute = 'setting';

  static String animation = 'animation';

  static String other = 'other';

  static String animationBottom = settingRoute + animation + 'bottom';
  static String animationBuilder = settingRoute + animation + 'builder';
  static String animationCustom = settingRoute + animation + 'custom';
  static String animationDiff = settingRoute + animation + 'diff';
  static String animationTest = settingRoute + animation + 'test';
  static String animationNormal = settingRoute + animation + 'normal';

  static String cavas = settingRoute + other + 'cavas';
  static String gesture = settingRoute + other + 'gesture';
  static String refresh = settingRoute + other + 'refresh';
  static String simpleWidget = settingRoute + other + 'simple';
  static String provider = settingRoute + other + 'provider';
  static String key = settingRoute + other + 'key';
  static String pageview = settingRoute + other + 'pageView';
  static String gloabKey = settingRoute + other + 'gloabKey';
  static String imagePicker = settingRoute + other + 'imagePicker';
  static String videoPlayer = settingRoute + other + 'videoPlayer';
  static String clip = settingRoute + other + 'clip';
  static String clipDetail = settingRoute + other + 'clipDetail';
  static String redux = settingRoute + other + 'redux';
  static String reduxDetail = settingRoute + other + 'reduxDetail';
  static String fishRedux = settingRoute + other + 'fishRedux';

  static getSettingPageRoutes(BuildContext context) {
    return <String, Widget Function(BuildContext)>{
      animationBottom: (_) => AnimationBottomPage(),
      animationBuilder: (_) => AnimationBuildDemoPage(),
      animationCustom: (_) => CustomAnimationView(),
      animationDiff: (_) => AnimationDiffDemoPage(),
      animationTest: (_) => TestAnimationPage(),
      animationNormal: (_) => AnimationDemoPage(),
      cavas: (_) => CanvasDemoPage(),
      gesture: (_) => GestureDemoPage(),
      refresh: (_) => RefreshDemoPage(),
      simpleWidget: (_) => SampleWidgetDemoPage(),
      provider: (_) => ProviderMorePage(),
      key: (_) => KeyDemoPage(),
      pageview: (_) => PageViewDemoPage(),
      gloabKey: (_) => GlobalDemoPage(),
      imagePicker: (_) => ImagePickerDemoPage(),
      videoPlayer: (_) => VideoPlayerPage(),
      clip: (_) => ClipDemoPage(),
      redux: (_) => ReduxDemoPage(),
      reduxDetail: (_) => ArticleDetailPage(),
    };
  }
}
