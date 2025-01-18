import 'package:weather_app_demo/utils/config.dart';

class WeatherInfoWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String value;
  const WeatherInfoWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: AppColors.lightPurple.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          CircularIcon(icon: icon),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }
}
