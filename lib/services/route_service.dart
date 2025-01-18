import 'package:go_router/go_router.dart';
import 'package:weather_app_demo/utils/config.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      debugPrint("state.fullPath ${state.fullPath}");
      return null;
    },
    routes: [
   GoRoute(path: '/' )
    ],
  );
  GoRouter get router => _router;
}
