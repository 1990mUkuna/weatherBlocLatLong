import 'package:equatable/equatable.dart';
import 'package:weather_bloc_lat_long/models/weather_model.dart'; 

// This is the bass class of event
class WeatherState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

// Step 1: Weather initial state
class WeatherIsNotSearchedState extends WeatherState {}

// Step 2: Load Weather
class WeatherLoadingState extends WeatherState {}

// Step 2: Weather was loaded
class WeatherLoadedState extends WeatherState {
  // ignore: prefer_typing_uninitialized_variables
  final weatherDatasery;
  WeatherLoadedState(this.weatherDatasery);
  List<Datasery> get getdatasery => weatherDatasery;
  @override
  // TODO: implement props
  List<Object> get props => [weatherDatasery];
}

// Step 2: Weather is not loaded will handle errore
class WeatherIsNotLoadedState extends WeatherState {}
