class RequestFactory {
  static T fromJson<T>(json) {
    if (json == null) {
      return null;
    } else {
      return json as T;
    }
  }

  static List<T> fromJsonList<T>(List jsonList) {
    if (jsonList == null) {
      return null;
    } else {
      List<T> list = List();
      jsonList.forEach((value) {
        list.add(value as T);
      });
      return list;
    }
  }
}
