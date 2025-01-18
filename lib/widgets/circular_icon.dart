import 'package:weather_app_demo/utils/config.dart';

class CircularIcon extends StatelessWidget {
  final String icon;
  const CircularIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: Colors.white,
      child: Image.asset(
        icon,
        height: 20,
      ),
    );
  }
}
