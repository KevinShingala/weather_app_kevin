class APIUrl {
  APIUrl._();

  // static String baseUrl = 'http://localhost:8080/api';
  static const String weatherApiKey = '5a3f9a1e52f976b742fd134d91f879c8';
  static const String googleApiKey = 'AIzaSyAY-pgTvvA-cg_DYqYunSVT8NWYqyfIfDI';
  static String weatherUrl =
      'https://api.openweathermap.org/data/2.5/weather?appid=${weatherApiKey}&units=metric';
  static String forecastUrl =
      'https://api.openweathermap.org/data/2.5/forecast?appid=${weatherApiKey}&units=metric';

  static String cityUrl =
      'https://maps.googleapis.com/maps/api/place/textsearch/json?key=${googleApiKey}';
}
