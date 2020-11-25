import 'package:flutter/material.dart';

import '../const/config.dart';

class AppManager extends ChangeNotifier {
  factory AppManager() => _getInstance();

  static AppManager get instance => _getInstance();
  static AppManager _instance;

  ThemeData _themeData;
  ThemeData get themeData => _themeData;
  AppManager._internal() {
    _themeData = ThemeData(
      primaryColor: theme_color,
    );
  }

  void configTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  static AppManager _getInstance() {
    if (_instance == null) {
      _instance = AppManager._internal();
    }
    return _instance;
  }
}
