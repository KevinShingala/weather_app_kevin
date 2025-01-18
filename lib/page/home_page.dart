import 'package:flutter/scheduler.dart';
import 'package:weather_app_demo/utils/config.dart';
import 'package:weather_app_demo/page/provider/home_provider.dart';
import 'package:weather_app_demo/page/search_city_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController? _scrollController;
  bool lastStatus = true;
  double height = 100;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
       SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().getCurrentLocation();
    });

  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldBgColor,
        body: context.watch<HomeProvider>().isLoading
            ? Center(child: CircularProgressIndicator())
            : CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            context.read<HomeProvider>().currentCity ?? "",
                            style: TextStyle(
                                fontSize: 22.0,
                                color: _isShrink
                                    ? AppColors.black
                                    : AppColors.white),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => SearchCityPage())),
                            child: Image.asset(AppIcons.search,
                                height: 30,
                                color: _isShrink
                                    ? AppColors.black
                                    : AppColors.white),
                          )
                        ],
                      ),
                      // MyAppBar(
                      //   isShrink: _isShrink,
                      //   searchTap: () {
                      //     Navigator.of(context).push(MaterialPageRoute(
                      //         builder: (context) => SearchCityPage()));
                      //   },
                      // ),
                      pinned: true,
                      backgroundColor: _isShrink
                          ? AppColors.lightPurple
                          : AppColors.scaffoldBgColor,
                      expandedHeight: 400,
                      collapsedHeight: 80,
                      flexibleSpace: FlexibleSpaceBar(
                        background: MyFlexibleAppBar(
                          timestamp:
                              context.read<HomeProvider>().weatherModel?.dt ??
                                  0,
                        ),
                      ),
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(60),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: _isShrink ? 60 : 170,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                      "${convertValue(context.read<HomeProvider>().weatherModel?.main?.temp ?? 0)}°",
                                      style: TextStyle(
                                          fontSize: 50,
                                          color: _isShrink
                                              ? AppColors.black
                                              : AppColors.white)),
                                  Text(
                                      "Feels like ${convertValue(context.read<HomeProvider>().weatherModel?.main?.feelsLike ?? 0)}°",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: _isShrink
                                              ? AppColors.black
                                              : AppColors.white)),
                                  Spacer(),
                                  if (!_isShrink) ...{
                                    Text(
                                        context
                                                .read<HomeProvider>()
                                                .weatherModel
                                                ?.weather
                                                ?.first
                                                .main ??
                                            '',
                                        style: const TextStyle(
                                            fontSize: 22, color: Colors.white)),
                                  } else ...{
                                    Image.asset(
                                      AppImages.cloudyAndSunny,
                                      height: 50,
                                    ),
                                  }
                                ],
                              ),
                            ),
                            SizedBox(height: _isShrink ? 30 : 150),
                          ],
                        ),
                      )),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: WeatherInfoWidget(
                                      icon: AppIcons.air,
                                      title: "Wind speed",
                                      value:
                                          "${context.read<HomeProvider>().weatherModel?.wind?.speed ?? ''} km/h",
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: WeatherInfoWidget(
                                      icon: AppIcons.waves,
                                      title: "Pressure",
                                      value:
                                          "${context.read<HomeProvider>().weatherModel?.main?.pressure ?? ''}  hpa",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            ForecastWidget(
                              weatherList: context
                                  .watch<HomeProvider>()
                                  .todaysWeatherList,
                              title: "Today's forecast",
                            ),
                            SizedBox(height: 20),
                            ForecastWidget(
                              weatherList: context
                                  .watch<HomeProvider>()
                                  .tomorrowsWeatherList,
                              title: "Tomorrow's forecast",
                            ),
                            SizedBox(height: 20),
                            ForecastWidget(
                              weatherList: context
                                  .watch<HomeProvider>()
                                  .thirdDayWeatherList,
                              title:
                                  "${context.read<HomeProvider>().thirdDayDate} forecast",
                            ),
                            SizedBox(height: 20),
                            ForecastWidget(
                              weatherList: context
                                  .watch<HomeProvider>()
                                  .fourthDayWeatherList,
                              title:
                                  "${context.read<HomeProvider>().fourthDayDate} forecast",
                            ),
                            SizedBox(height: 20),
                            ForecastWidget(
                              weatherList: context
                                  .watch<HomeProvider>()
                                  .fifthDayWeatherList,
                              title:
                                  "${context.read<HomeProvider>().fifthDayDate} forecast",
                            ),
                            SizedBox(height: 20),
                            ForecastWidget(
                              weatherList: context
                                  .watch<HomeProvider>()
                                  .sixthDayWeatherList,
                              title:
                                  "${context.read<HomeProvider>().sixthDayDate} forecast",
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }
}
