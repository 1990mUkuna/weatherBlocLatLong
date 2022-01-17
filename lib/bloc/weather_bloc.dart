
import 'package:bloc/bloc.dart';
import 'package:weather_bloc_lat_long/bloc/weather_event.dart';
import 'package:weather_bloc_lat_long/bloc/weather_state.dart';
import 'package:weather_bloc_lat_long/models/weather_model.dart';
import 'package:weather_bloc_lat_long/repository/weather_repository.dart'; 

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  // Initializing weather repo as a constructor
  final WeatherRepo weatherRepo;
  WeatherBloc(this.weatherRepo);
  @override
  WeatherState get initialState => WeatherIsNotSearchedState();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeatherEvent) {
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
    }
  }
}
