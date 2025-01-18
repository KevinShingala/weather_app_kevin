import 'package:dio/dio.dart';
import 'package:weather_app_demo/http_client/http_client.dart';

class RequestExecutor {
  late final Dio _dio;
  late final Request _request;

  RequestExecutor({required Dio dio, required Request request}) {
    _dio = dio;
    _request = request;
  }

  Future<Response<dynamic>> execute() async {
    try {
      return await _dio.request(
        _request.path,
        data: _request.data,
        options: Options(
          method: _request.method?.name,
          headers: _request.headers,
        ),
      );
    } on DioException catch (e) {
      Response<dynamic>? response = e.response;
      if (response != null) {
        return response;
      } else {
        throw OkHttpClientException(e.error.toString());
      }
    } catch (e) {
      throw OkHttpClientException(e.toString());
    }
  }
}
