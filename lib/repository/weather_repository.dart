import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_bloc_lat_long/models/weather_model.dart';
 

class WeatherRepo {
  Future<List<Datasery>> getDatasery(String long, lat, unit) async {
    //lat:23.1 long: 113.2
    final result = await http.Client().get(
        "https://www.7timer.info/bin/astro.php?lon=$long&lat=$lat&ac=0&$unit=metric&output=json&tzshift=0");
    if (result.statusCode != 200) throw Exception();
    return parsedJson(result.body);
  }

  List<Datasery> parsedJson(final response) {
    final jsonDecoded = json.decode(response);
    //maping the dataseries
    final jsonDataseries = jsonDecoded["dataseries"] as List;
    return jsonDataseries.map((e) => Datasery.fromJson(e)).toList();
  }
}
