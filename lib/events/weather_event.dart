// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

// This is the bass class of event
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherEventRequested extends WeatherEvent {
  final String long, lat, unit;
  const WeatherEventRequested(this.lat, this.long, this.unit);
  @override
  List<Object> get props => [long, lat, unit];
}

class WeatherEventRefresh extends WeatherEvent {
  final String long, lat, unit;
  const WeatherEventRefresh(
      {@required this.long, @required this.lat, @required this.unit})
      : assert(long != null && lat != null && unit != unit);
  @override
  List<Object> get props => [long, lat, unit];
}
