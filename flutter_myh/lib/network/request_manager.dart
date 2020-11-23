import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'request_data/request_response_model.dart';

typedef RequestCallBack<T> = dynamic Function(T response);

enum HttpMethod {
  get,
  post,
  upload,
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
      receiveTimeout: 1000,
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
    Map requestBody,
    RequestCallBack<T> success,
    RequestCallBack error,
  }) async {
    _request<T>(
      HttpMethod.get,
      url,
      requestBody,
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

  upload<T>(
    String url,
    Map requestBody, {
    @required FormData data,
    RequestCallBack success,
    RequestCallBack error,
    RequestCallBack progress,
  }) async {
    _request<T>(
      HttpMethod.upload,
      url,
      requestBody,
      success: success,
      error: error,
      progress: progress,
    );
  }

  _request<T>(
    HttpMethod method,
    String url,
    Map requestBody, {
    RequestCallBack success,
    RequestCallBack error,
    RequestCallBack progress,
  }) async {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {},
      onResponse: (Response response) {},
      onError: (DioError error) {},
    ));

    try {
      Response response = await _getResponse(
        method,
        url,
        requestBody,
        progress: progress,
      );
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

  _getResponse(
    HttpMethod method,
    String url,
    Map requestBody, {
    FormData data,
    RequestCallBack progress,
  }) async {
    Response response;
    switch (method) {
      case HttpMethod.get:
        response = await _dio.get(
          url,
          queryParameters: requestBody ?? {},
        );
        break;
      case HttpMethod.post:
      case HttpMethod.upload:
        response = await _dio.post(
          url,
          queryParameters: requestBody ?? {},
          data: data,
          onSendProgress: (count, total) {
            if (progress != null) {
              progress(count.toDouble() / total);
            }
          },
        );
        break;
      default:
    }
    return response;
  }
}
