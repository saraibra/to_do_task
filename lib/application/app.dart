import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/presentation/main_screen/cubit/main_cubit.dart';
import 'package:to_do_app/presentation/schedule/cubit/schedule_cubit.dart';

import '../presentation/resources/route_manager.dart';

import '../presentation/resources/theme_manager.dart';


class MyApp extends StatefulWidget {
  // named constructor
  MyApp._internal();

  int appState = 0;

  static final MyApp _instance =
      MyApp._internal(); // singleton or single instance

  factory MyApp() => _instance; // factory

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       BlocProvider(
        create: (BuildContext context) => MainCubit()..createDatabase()),
         BlocProvider(
        create: (BuildContext context) => ScheduleCubit())
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.mainRoute,
        theme: getApplicationTheme(),
      ),
    );
  }
}