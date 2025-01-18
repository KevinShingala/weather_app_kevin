import 'package:weather_app_demo/utils/config.dart';
import 'package:weather_app_demo/page/home_page.dart';
import 'package:weather_app_demo/page/provider/home_provider.dart';
import 'package:weather_app_demo/utils/preferences/preference_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPrefs().init();
  runApp(registerProvider());
}

Widget registerProvider() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: HomeProvider()),
    ],
    child: const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  HomePage(),
    );
  }
}




// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: FirstPage(),
//     );
//   }
// }

// class FirstPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('First Page')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Navigate to the second page, replacing the current page
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => SecondPage()),
//             );
//           },
//           child: Text('Go to Second Page'),
//         ),
//       ),
//     );
//   }
// }

// class SecondPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Second Page')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Navigate back to the first page without going to the second page again
//             Navigator.pop(context);
//           },
//           child: Text('Back to First Page'),
//         ),
//       ),
//     );
//   }
// }
