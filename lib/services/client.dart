import 'dart:developer';

import 'package:weather_app_demo/http_client/http_client.dart';
import 'package:weather_app_demo/modules/connectivity_utils.dart';

class EventClient<T> {
  final HttpClient _client =
      HttpClient.builder().setOptions(BaseOptions(baseUrl: ''));

  Future<Result<T, String>> handleRequest(Request request) async {
    try {
      if (await ConnectivityUtils.isConnected) {
        log(request.path, name: "URL");
        log(request.data.toString(), name: "Body");
        log(request.headers.toString(), name: "Header");

        Response<dynamic> response = await _client.newCall(request).execute();

        log(response.data.toString(), name: "BaseResponse ${request.path}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          (response.data);

          return Success(response.data);
        } else if (response.statusCode == 401) {
          /// Auto logout if 401 response returned from api

          return Failure("Something Went Wrong");
        } else if (response.statusCode == 400) {
          return Failure(response.data['message'].toString());
        } else {
          log(response.toString(),
              name: "Error api called ${response.statusCode}");
          return Failure("Something Went Wrong");
        }
      } else {
        return Failure(
            'No Internet connection. Make sure that Wi-Fi or Mobile data is turned on, then try again.');
      }
    } on OkHttpClientException catch (e) {
      log(e.toString(), name: "Error in OkHttpClientException");

      return Failure("OkHttpClientException");
    } catch (e) {
      log(e.toString(), name: "Error in catch handleRequest");

      return Failure("Error in catch Something");
    }
  }
}

abstract class Result<S, F> {
  T when<T>(T Function(S value) ifSuccess, T Function(F error) ifFailure);
}

class Success<S, F> extends Result<S, F> {
  final S _value;

  Success(this._value);

  S get value => _value;

  @override
  T when<T>(T Function(S s) ifSuccess, T Function(F f) ifFailure) =>
      ifSuccess(_value);
}

class Failure<S, F> extends Result<S, F> {
  final F _value;

  Failure(this._value);

  F get value => _value;

  @override
  T when<T>(T Function(S s) ifSuccess, T Function(F f) ifFailure) =>
      ifFailure(_value);
}
