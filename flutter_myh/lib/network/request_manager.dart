import 'package:dio/dio.dart';
import 'request_data/request_response_model.dart';

typedef RequestCallBack<T> = dynamic Function(T response);

enum HttpMethod {
  get,
  post,
}

/*
example 
RequestManager.instance.post<xxModel>(
      'xxurl',
      requestBody,
      success: (response) {},
      error: (response) {},
    );

*/

class RequestManager {
  static int successCode = 200;
  static String baseURL = '';

  factory RequestManager() => _getInstance();

  static RequestManager _instance;
  static RequestManager get instance => _getInstance();

  RequestManager._interal() {
    _options = BaseOptions(
      connectTimeout: 60000,
      receiveTimeout: 500,
      baseUrl: baseURL,
      headers: {},
    );
    _dio = Dio(_options);
  }

  Dio _dio;
  BaseOptions _options;

  static RequestManager _getInstance() {
    if (_instance == null) {
      _instance = RequestManager._interal();
    }
    return _instance;
  }

  get<T>(
    String url, {
    RequestCallBack<T> success,
    RequestCallBack error,
  }) async {
    _request<T>(
      HttpMethod.get,
      url,
      null,
      success: success,
      error: error,
    );
  }

  post<T>(
    String url,
    Map requestBody, {
    RequestCallBack success,
    RequestCallBack error,
  }) async {
    _request<T>(
      HttpMethod.post,
      url,
      requestBody,
      success: success,
      error: error,
    );
  }

  _request<T>(
    HttpMethod method,
    String url,
    Map requestBody, {
    RequestCallBack success,
    RequestCallBack error,
  }) async {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {},
      onResponse: (Response response) {},
      onError: (DioError error) {},
    ));

    try {
      Response response = await _getResponse(method, url, requestBody);
      if (response.statusCode == successCode) {
        if (success != null) {
          success(BaseRequestData<T>.fromJson(response.data));
        }
      } else {
        if (error != null) {
          error(response.data);
        }
      }
    } catch (e) {
      if (error != null) {
        error(e.toString());
      }
    }
  }

  _getResponse(HttpMethod method, String url, Map requestBody) async {
    Response response;
    switch (method) {
      case HttpMethod.get:
        response = await _dio.get(url);
        break;
      case HttpMethod.post:
        response = await _dio.post(
          url,
          queryParameters: requestBody,
        );
        break;
      default:
    }
    return response;
  }
}
