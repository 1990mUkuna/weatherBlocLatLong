// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:equatable/equatable.dart';

// This is the bass class of event
class WeatherEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchWeatherEvent extends WeatherEvent {
  final long, lat, unit;
  FetchWeatherEvent(this.lat, this.long, this.unit);
  @override
  // TODO: implement props
  List<Object> get props => [long, lat, unit];
}

class ResetWeatherEvent extends WeatherEvent {}
