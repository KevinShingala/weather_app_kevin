import 'package:weather_app_demo/utils/config.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_demo/models/weather_model.dart';
import 'package:weather_app_demo/repo/weather_repo.dart';
import 'package:weather_app_demo/services/client.dart';
import 'package:weather_app_demo/utils/preferences/pref_keys.dart';
import 'package:weather_app_demo/utils/preferences/preference_manager.dart';

class HomeProvider extends ChangeNotifier {
  WeatherRepo weatherRepo = WeatherRepo.instance;
  WeatherModel? weatherModel;
  List<WeatherModel> weatherList = [];
  List<WeatherModel> todaysWeatherList = [];
  List<WeatherModel> tomorrowsWeatherList = [];
  List<WeatherModel> thirdDayWeatherList = [];
  List<WeatherModel> fourthDayWeatherList = [];
  List<WeatherModel> fifthDayWeatherList = [];
  List<WeatherModel> sixthDayWeatherList = [];
  String thirdDayDate = '';
  String fourthDayDate = '';
  String fifthDayDate = '';
  String sixthDayDate = '';
  List<CityModel> cityList = [];
  int selectedButtonIndex = 1;
  bool isLoading = false;
  String? currentCity;

  void updateBtnTap(int value) {
    selectedButtonIndex = value;
    notifyListeners();
  }

  void setLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> getCurrentWeather({required String city}) async {
    try {
      Result<WeatherModel, String> result =
          await weatherRepo.getCurrentWeather(city: city);

      result.when((response) async {
        weatherModel = response;
        notifyListeners();
      }, (error) {
        notifyListeners();
      });
    } catch (e) {
      notifyListeners();
    }
  }

  Future<void> getForecast({required String city}) async {
    try {
      Result<List<WeatherModel>, String> result =
          await weatherRepo.getForecast(city: city);
      result.when((response) async {
        weatherList = response;
        DateTime today = DateTime.now();
        DateTime tomorrow = today.add(Duration(days: 1));
        DateTime thirdDay = today.add(Duration(days: 2));
        DateTime fourthDay = today.add(Duration(days: 3));
        DateTime fifthDay = today.add(Duration(days: 4));
        DateTime sixthDay = today.add(Duration(days: 5));
        String todayString = DateFormat('yyyy-MM-dd').format(today);
        String tomorrowString = DateFormat('yyyy-MM-dd').format(tomorrow);
        String thirdDayString = DateFormat('yyyy-MM-dd').format(thirdDay);
        String fourthDayString = DateFormat('yyyy-MM-dd').format(fourthDay);
        String fifthDayString = DateFormat('yyyy-MM-dd').format(fifthDay);
        String sixthDayString = DateFormat('yyyy-MM-dd').format(sixthDay);

        thirdDayDate = DateFormat('d MMMM').format(thirdDay);
        fourthDayDate = DateFormat('d MMMM').format(fourthDay);
        fifthDayDate = DateFormat('d MMMM').format(fifthDay);
        sixthDayDate = DateFormat('d MMMM').format(sixthDay);

        todaysWeatherList = _filterWeatherListByDate(response, todayString);
        tomorrowsWeatherList =
            _filterWeatherListByDate(response, tomorrowString);
        thirdDayWeatherList =
            _filterWeatherListByDate(response, thirdDayString);
        fourthDayWeatherList =
            _filterWeatherListByDate(response, fourthDayString);
        fifthDayWeatherList =
            _filterWeatherListByDate(response, fifthDayString);
        sixthDayWeatherList =
            _filterWeatherListByDate(response, sixthDayString);
        notifyListeners();
      }, (error) {
        // ToastService.show(error);
        notifyListeners();
      });
    } catch (e) {
      // ToastService.show(e.toString());
      notifyListeners();
    }
  }

  List<WeatherModel> _filterWeatherListByDate(
      List<WeatherModel> weatherList, String dateString) {
    return weatherList.where((item) {
      DateTime itemDate = DateFormat('yyyy-MM-dd').parse(item.dt_txt ?? '');
      String itemDateString = DateFormat('yyyy-MM-dd').format(itemDate);
      return itemDateString == dateString;
    }).toList();
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission;
    setLoading();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, don't continue
        setLoading();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, don't continue
      setLoading();
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    _getCityName(position);
  }

  void setCurrentCity(String city) {
    currentCity = city;
    AppPrefs().setString(AppPrefKeys.city, currentCity ?? '');
    notifyListeners();
  }

  Future<void> fetchCityWeatherData(String city) async {
    setCurrentCity(city);
    await getCurrentWeather(city: city);
    await getForecast(city: city);
  }

  Future<void> _getCityName(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];

    String city = "${place.locality}, ${place.administrativeArea}";
    String storedCity = AppPrefs().getString(AppPrefKeys.city);
    if (storedCity.isEmpty) {
      setLoading();
      await fetchCityWeatherData(city);
    } else {
      currentCity = storedCity;
      setLoading();
      await fetchCityWeatherData(storedCity);
    }

    notifyListeners();
  }

  Future<void> getCity({required String query}) async {
    try {
      Result<List<CityModel>, String> result =
          await weatherRepo.getCity(query: query);
      cityList = [];
      result.when((response) async {
        cityList = response;
        notifyListeners();
      }, (error) {
        // ToastService.show(error);
        notifyListeners();
      });
    } catch (e) {
      // ToastService.show(e.toString());
      notifyListeners();
    }
  }
}
