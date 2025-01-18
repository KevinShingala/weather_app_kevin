import 'package:weather_app_demo/http_client/http_client.dart';
import 'package:weather_app_demo/models/city_model.dart';
import 'package:weather_app_demo/models/weather_model.dart';
import 'package:weather_app_demo/services/api_url.dart';
import 'package:weather_app_demo/services/client.dart';

abstract class WeatherRepo {
  static WeatherRepo get instance => _WeatherRepoImpl();

  Future<Result<WeatherModel, String>> getCurrentWeather({
    required String city,
  });
  Future<Result<List<WeatherModel>, String>> getForecast({
    required String city,
  });

  Future<Result<List<CityModel>, String>> getCity({
    required String query,
  });
}

class _WeatherRepoImpl implements WeatherRepo {
  final EventClient _client;

  _WeatherRepoImpl() : _client = EventClient();

  @override
  Future<Result<WeatherModel, String>> getCurrentWeather(
      {required String city}) async {
    Request request =
        Request.builder().setPath('${APIUrl.weatherUrl}&q=$city').get().build();
    var result = await _client.handleRequest(request);
    return result.when((response) {
      WeatherModel weatherModel = WeatherModel.fromJson(response);
      return Success(weatherModel);
    }, (error) => Failure(error));
  }

  @override
  Future<Result<List<WeatherModel>, String>> getForecast(
      {required String city}) async {
    Request request = Request.builder()
        .setPath('${APIUrl.forecastUrl}&q=$city')
        .get()
        .build();
    var result = await _client.handleRequest(request);
    return result.when((response) {
      List<WeatherModel> weather = [];
      for (var item in response['list']) {
        weather.add(WeatherModel.fromJson(item));
      }
      return Success(weather);
    }, (error) => Failure(error));
  }

  @override
  Future<Result<List<CityModel>, String>> getCity(
      {required String query}) async {
    Request request = Request.builder()
        .setPath('${APIUrl.cityUrl}&query=$query')
        .get()
        .build();
    var result = await _client.handleRequest(request);
    return result.when((response) {
      List<CityModel> city = [];
      for (var item in response['results']) {
        city.add(CityModel.fromJson(item));
      }
      return Success(city);
    }, (error) => Failure(error));
  }
}
