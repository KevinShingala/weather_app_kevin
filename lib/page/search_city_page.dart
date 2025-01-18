import 'dart:async';

import 'package:weather_app_demo/page/provider/home_provider.dart';
import 'package:weather_app_demo/utils/config.dart';
import 'package:weather_app_demo/utils/preferences/preference_manager.dart';

class SearchCityPage extends StatefulWidget {
  const SearchCityPage({super.key});

  @override
  State<SearchCityPage> createState() => _SearchCityPageState();
}

class _SearchCityPageState extends State<SearchCityPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeProvider>().cityList.clear();
  }

  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      appBar: AppBar(
        title: Text("Select City"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                onTapOutside: (event) {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus &&
                      currentFocus.focusedChild != null) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(Duration(milliseconds: 500), () {
                    context.read<HomeProvider>().getCity(query: value);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search City...',
                  contentPadding: EdgeInsets.all(10),
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: context.watch<HomeProvider>().cityList.length,
                  itemBuilder: (context, index) {
                    CityModel cityModel =
                        context.read<HomeProvider>().cityList[index];
                    return ListTile(
                      onTap: () {
                        context
                            .read<HomeProvider>()
                            .fetchCityWeatherData(cityModel.name ?? '');
                        Navigator.pop(context);
                      },
                      title: Text(
                        cityModel.name ?? '',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
