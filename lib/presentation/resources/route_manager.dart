import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/add_task/view/add_task.dart';
import 'package:to_do_app/presentation/main_screen/view/main_screen.dart';
import 'package:to_do_app/presentation/resources/string_manager.dart';
import 'package:to_do_app/presentation/schedule/view/schedule_view.dart';

class Routes {
  static const String mainRoute = "/";
  static const String addTask = "/addTask";
    static const String schedule = "/schedule";


}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.splashRoute:
      //   return MaterialPageRoute(builder: (_) => const SplashView());
    
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case Routes.addTask:
        return MaterialPageRoute(builder: (_) =>  AddTask());
        //  case Routes.schedule:
        // return MaterialPageRoute(builder: (_) =>  ScheduleView());
      default:
        return unDefinedRoute();
    }
  }
  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
