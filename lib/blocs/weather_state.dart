import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_bloc_lat_long/models/weather_model.dart';

// This is the bass class of event
abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherSuccesState extends WeatherState {
  final List<Datasery> weatherDatasery;

  const WeatherSuccesState({@required this.weatherDatasery})
      : assert(weatherDatasery != null);
  @override
  List<Object> get props => [weatherDatasery];
}

class WeatherIsNotLoadedState extends WeatherState {}

class WeatherStateFailure extends WeatherState {}
