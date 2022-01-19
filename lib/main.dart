import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc_lat_long/presentation/screem/home.dart';
import 'package:weather_bloc_lat_long/repository/weather_repository.dart';
import 'package:http/http.dart' as http;

import 'blocs/weather_bloc.dart';
import 'blocs/weather_bloc_observer.dart';

void main() async {
  Bloc.observer = WeatherBlocObserver();
  final WeatherRepo weatherRepo = WeatherRepo(httpClient: http.Client());
  runApp(BlocProvider(
    create: (context) => WeatherBloc(weatherRepo: weatherRepo),
    child: MyApp(
      weatherRepo: weatherRepo,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final WeatherRepo weatherRepo;
  const MyApp({Key key, @required this.weatherRepo})
      : assert(weatherRepo != null),
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // ignore: prefer_const_constructors
        home: Home());
  }
}
