import 'package:weather_app_demo/page/provider/home_provider.dart';
import 'package:weather_app_demo/utils/config.dart';
class MyAppBar extends StatefulWidget {
  final bool isShrink;
  final void Function()? searchTap;
  const MyAppBar({super.key, required this.isShrink, required this.searchTap});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeProvider>().getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          context.read<HomeProvider>().currentCity ?? "",
          style: TextStyle(
              fontSize: 22.0,
              color: widget.isShrink ? AppColors.black : AppColors.white),
        ),
        GestureDetector(
          onTap: widget.searchTap,
          child: Image.asset(AppIcons.search,
              height: 30,
              color: widget.isShrink ? AppColors.black : AppColors.white),
        )
      ],
    );
  }
}
