import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_bloc_lat_long/blocs/weather_event.dart';
import 'package:weather_bloc_lat_long/blocs/weather_state.dart';
import 'package:weather_bloc_lat_long/models/weather_model.dart';
import 'package:weather_bloc_lat_long/repository/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  // Initializing weather repo as a constructor
  final WeatherRepo weatherRepo;
  WeatherBloc({@required this.weatherRepo})
      : assert(weatherRepo != null),
        super(WeatherInitialState());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent) async* {
    if (weatherEvent is WeatherEventRequested) {
      yield WeatherLoadingState();
      try {
        final List<Datasery> datasery = await weatherRepo.getDatasery(
            weatherEvent.lat, weatherEvent.long, weatherEvent.unit);
        yield WeatherSuccesState(weatherDatasery: datasery);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    } else if (weatherEvent is WeatherEventRefresh) {
      try {
        final List<Datasery> datasery = await weatherRepo.getDatasery(
            weatherEvent.lat, weatherEvent.long, weatherEvent.unit);
        yield WeatherSuccesState(weatherDatasery: datasery);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    }

    /* if (event is FetchWeatherEvent) {
      yield WeatherLoadingState();
      try {
        List<Datasery> datasery =
            await weatherRepo.getDatasery(event.long, event.lat, event.unit);
        yield WeatherLoadedState(datasery);
      } catch (_) {
        yield WeatherIsNotLoadedState();
      }
    } else if (event is ResetWeatherEvent) {
      yield WeatherIsNotSearchedState();
    } */
  }
}
