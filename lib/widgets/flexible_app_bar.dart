import 'package:weather_app_demo/utils/config.dart';

class MyFlexibleAppBar extends StatelessWidget {
  final int timestamp;
  const MyFlexibleAppBar({super.key, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Column(
          children: [
            Container(
              height: 428,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  image: DecorationImage(
                    image: AssetImage(AppImages.bgImg),
                    fit: BoxFit.fill,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(dateAndTime(timestamp: timestamp),
                            style: const TextStyle(
                                fontSize: 18.0, color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 18, bottom: 80),
          child: Image.asset(
            AppImages.cloudyAndSunny,
            height: 80,
          ),
        ),
      ],
    );
  }
}
