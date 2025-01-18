import 'package:intl/intl.dart';
import 'package:weather_app_demo/models/weather_model.dart';
import 'package:weather_app_demo/utils/config.dart';

class ForecastWidget extends StatelessWidget {
  final List<WeatherModel> weatherList;
  final String title;

  const ForecastWidget(
      {super.key, required this.weatherList, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.lightPurple.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircularIcon(icon: AppIcons.clock),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 90,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: weatherList.length,
                itemBuilder: (context, index) {
                  WeatherModel weatherModel = weatherList[index];
                  DateTime weatherDate =
                      DateTime.parse(weatherModel.dt_txt ?? '');
                  String displayTime = DateFormat('h a').format(weatherDate);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      children: [
                        Text(displayTime),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Image.asset(
                            weatherModel.weather?.first.main == "Clear"
                                ? AppImages.cloudyAndSunny
                                : AppImages.cloudy,
                            height: 34,
                          ),
                        ),
                        Text(
                          "${convertValue(weatherModel.main?.temp ?? 0)}°",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
