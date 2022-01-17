import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc_lat_long/bloc/weather_bloc.dart';
import 'package:weather_bloc_lat_long/events/weather_event.dart';
import 'package:weather_bloc_lat_long/states/weather_state.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _completer = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    //final weatherBloc = BlocProvider.of(create: create)
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hello2"),
        ),
        body: Column(
          children: [
            Form(
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
            IconButton(
                onPressed: () async {
                  BlocProvider.of<WeatherBloc>(context).add(
                      WeatherEventRequested(_latController.text,
                          _longController.text, _unitController.text));
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ))
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
