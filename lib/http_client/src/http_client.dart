import 'package:dio/dio.dart';
import 'package:weather_app_demo/http_client/src/request.dart';
import 'package:weather_app_demo/http_client/src/request_executor.dart';

abstract class HttpClient {
  static HttpClient builder() => _HttpClientBuilder._();

  HttpClient setOptions(BaseOptions options);

  HttpClient addInterceptor(Interceptor? interceptor);

  HttpClient addAllInterceptors(Iterable<Interceptor> interceptors);

  RequestExecutor newCall(Request request);
}

class _HttpClientBuilder extends _DioClient implements HttpClient {
  _HttpClientBuilder._();

  @override
  HttpClient setOptions(BaseOptions options) {
    _dio.options = options;
    return this;
  }

  @override
  HttpClient addInterceptor(Interceptor? interceptor) {
    if (interceptor != null) {
      _dio.interceptors.add(interceptor);
    } else {
      _dio.interceptors.clear();
    }
    return this;
  }

  @override
  HttpClient addAllInterceptors(Iterable<Interceptor> interceptors) {
    if (interceptors.isNotEmpty) {
      _dio.interceptors.addAll(interceptors);
    } else {
      _dio.interceptors.clear();
    }
    return this;
  }

  @override
  RequestExecutor newCall(Request request) {
    return RequestExecutor(dio: _dio, request: request);
  }
}

class _DioClient {
  final Dio _dio = Dio();
}
