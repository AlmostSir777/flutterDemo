import './request_json.dart';

class BaseRequestData<T> {
  int resultCode;
  String message;
  T result;

  List<T> data;

  BaseRequestData({
    this.resultCode,
    this.message,
    this.result,
    this.data,
  });
  factory BaseRequestData.fromJson(json) {
    BaseRequestData data = BaseRequestData(
      resultCode: json['code'],
      message: json['message'],
      result: RequestFactory.fromJson<T>(json['data']),
    );
    return data;
  }

  factory BaseRequestData.fromJsonList(json) {
    BaseRequestData data = BaseRequestData(
      resultCode: json['code'],
      message: json['message'],
      result: RequestFactory.fromJsonList<T>(json['data']),
    );
    return data;
  }
}
