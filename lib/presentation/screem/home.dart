import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc_lat_long/blocs/weather_bloc.dart';
import 'package:weather_bloc_lat_long/events/weather_event.dart';
import 'package:weather_bloc_lat_long/states/weather_state.dart';

import 'datasery_screen.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _latController = TextEditingController();
  final _longController = TextEditingController();
  final _unitController = TextEditingController();
  Completer<void> _completer;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _completer = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    // final weatherBloc = BlocProvider.of(create: create)
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hello2"),
        ),
        body: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextFormField(
                        controller: _latController,
                        decoration: const InputDecoration(
                          labelText: "Enter Your Latidude",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextFormField(
                        controller: _longController,
                        decoration: const InputDecoration(
                          labelText: "Enter Your Longitude",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextFormField(
                        controller: _unitController,
                        decoration: const InputDecoration(
                          labelText: "Enter Your Unit",
                        ),
                      ),
                    )
                  ],
                )),
            FlatButton(
                color: Colors.black,
                onPressed: () async {
                  BlocProvider.of<WeatherBloc>(context).add(
                      WeatherEventRequested(_latController.text,
                          _longController.text, _unitController.text));

                  /*         Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DataseryScreen())); */
                },
                child: const Text(
                  "Check Weather",
                  style: TextStyle(color: Colors.white),
                )),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                // ignore: avoid_unnecessary_containers
                Container(
                  child: BlocConsumer<WeatherBloc, WeatherState>(
                      listener: (context, weatherState) {
                    if (weatherState is WeatherSuccesState) {
                      Text(weatherState.weatherDatasery.first.cloudcover
                          .toString());
                      _completer?.complete();
                      _completer = Completer();
                    }
                  }, builder: (context, weatherState) {
                    if (weatherState is WeatherLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (weatherState is WeatherSuccesState) {
                      final weather = weatherState.weatherDatasery;
                      return RefreshIndicator(
                          onRefresh: () {
                            BlocProvider.of<WeatherBloc>(context)
                                .add(WeatherEventRefresh(
                              lat: _latController.text,
                              long: _longController.text,
                              unit: _unitController.text,
                            ));
                            //return a "Completer object"
                            return _completer.future;
                          },
                          child: Row(
                            children: [
                              Text(
                                weather.first.cloudcover.toString(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ],
                          ));
                    }
                    if (weatherState is WeatherStateFailure) {
                      return const Text(
                        'Something went wrong',
                        style: TextStyle(color: Colors.redAccent, fontSize: 16),
                      );
                    }
                    return const Center(
                      child: Text(
                        'select a location first !',
                        style: TextStyle(fontSize: 30),
                      ),
                    );
                  }),
                ),
              ],
            )
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
