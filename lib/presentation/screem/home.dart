// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc_lat_long/blocs/weather_bloc.dart';
import 'package:weather_bloc_lat_long/blocs/weather_event.dart';
import 'package:weather_bloc_lat_long/presentation/widgets/app_primary_btn.dart';
import 'package:weather_bloc_lat_long/presentation/widgets/app_text_field.dart';
import 'package:weather_bloc_lat_long/presentation/widgets/field_label.dart';
import 'package:weather_bloc_lat_long/blocs/weather_state.dart';

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
    super.initState();
    _completer = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF010035),
          title: const Center(child: Text("7timer Weather")),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: height * 0.04,
            ),
            child: Column(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.05,
                          ),
                          child: Row(
                            children: [
                              FieldLable(
                                labelText: 'Longitude',
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.05,
                            right: width * 0.05,
                            top: height * 0.02,
                            bottom: height * 0.01,
                          ),
                          child: AppTextField(
                            controller: _longController,
                            hintText: "Enter Your Longitude",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.05,
                          ),
                          child: Row(
                            children: [
                              FieldLable(
                                labelText: 'Latidude',
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.05,
                            right: width * 0.05,
                            top: height * 0.01,
                            bottom: height * 0.01,
                          ),
                          child: AppTextField(
                            controller: _latController,
                            hintText: "Enter Your Latidude",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.05,
                          ),
                          child: Row(
                            children: [
                              FieldLable(
                                labelText: 'Unit e.g: celsius',
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.05,
                            right: width * 0.05,
                            top: height * 0.01,
                            bottom: height * 0.04,
                          ),
                          child: AppTextField(
                            controller: _unitController,
                            hintText: "Enter Your Unit",
                          ),
                        ),
                      ],
                    )),
                AppPrimaryButton(
                    onPressed: () async {
                      bool isValid = _formKey.currentState.validate();
                      if (isValid) {
                        BlocProvider.of<WeatherBloc>(context).add(
                            WeatherEventRequested(_latController.text,
                                _longController.text, _unitController.text));
                      }
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
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (weatherState is WeatherSuccesState) {
                          final weather = weatherState.weatherDatasery;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: 100,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: weather.map((datasery) {
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Text(
                                              datasery.cloudcover.toString()),
                                        );
                                      }).toList(),
                                    )),
                              ],
                            ),
                          );
                        }
                        if (weatherState is WeatherStateFailure) {
                          return const Text(
                            'Something went wrong',
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 16),
                          );
                        }
                        return Center(
                            // ignore: sized_box_for_whitespace
                            child: Container(
                          child: const FlareActor(
                            "assets/WorldSpin.flr",
                            fit: BoxFit.contain,
                            animation: "roll",
                          ),
                          height: 300,
                          width: 300,
                        ));
                      }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
