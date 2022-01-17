import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc_lat_long/bloc/weather_bloc.dart';
import 'package:weather_bloc_lat_long/bloc/weather_bloc_observer.dart';
import 'package:weather_bloc_lat_long/presentation/screem/home.dart';
import 'package:weather_bloc_lat_long/repository/weather_repository.dart';
import 'package:http/http.dart' as http;

void main() async {
  Bloc.observer = WeatherBlocObserver();
  final WeatherRepo weatherRepo = WeatherRepo(httpClient: http.Client());
  runApp(MyApp(
    weatherRepo: weatherRepo,
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // ignore: prefer_const_constructors
      home: BlocProvider(
          create: (context) => WeatherBloc(weatherRepo: weatherRepo),
          child: Home()),
    );
  }
}

/* class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
 */