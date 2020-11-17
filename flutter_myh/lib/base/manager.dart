class AppManager {
  factory AppManager() => _getInstance();

  static AppManager get instance => _getInstance();
  static AppManager _instance;

  int _num = 0;
  int get num => _num;

  AppManager._internal();

  void addNum() {
    _num++;
    print('num = ${_num.toString()}');
  }

  static AppManager _getInstance() {
    if (_instance == null) {
      _instance = AppManager._internal();
    }
    return _instance;
  }
}
