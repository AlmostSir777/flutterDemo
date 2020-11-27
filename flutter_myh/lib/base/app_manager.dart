import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/config.dart';

class AppManager extends ChangeNotifier {
  static String themeKey = 'themeKey';

  factory AppManager() => _getInstance();

  static AppManager get instance => _getInstance();
  static AppManager _instance;

  ThemeData _themeData;
  ThemeData get themeData => _themeData;

  AppManager._internal() {
    _themeData = ThemeData(
      primaryColor: theme_color,
    );
    _initTheme();
  }

  void _initTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int colorValue = sharedPreferences.getInt(themeKey);
    Color color;
    if (colorValue != null) {
      color = Color(colorValue);
      print(color);
      if (color != _themeData.primaryColor) {
        configThemeWithBarColor(color);
      }
    }
  }

  void configThemeWithBarColor(Color color) async {
    ThemeData themeData = ThemeData(
      primaryColor: color,
    );
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isSuccess = await sharedPreferences.setInt(
      themeKey,
      themeData.primaryColor.value,
    );
    print('保存成功' + isSuccess.toString());
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
