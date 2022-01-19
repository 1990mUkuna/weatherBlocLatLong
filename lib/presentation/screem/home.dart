// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
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
                                CarouselSlider(
                                  items: weather.map((datasery) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      // ignore: avoid_unnecessary_containers
                                      child: Container(
                                        color: Colors.blueAccent,
                                        width: 300,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Time Point : ${datasery.timepoint}    /   Cloud Cover : ${datasery.cloudcover} "
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.05,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Seing: ${datasery.seeing}  /  Transparency : ${datasery.seeing}  "
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.05,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Lifted Index: ${datasery.liftedIndex}    /   Rh2m : ${datasery.rh2M}  "
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.05,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Wind 10m: ${datasery.wind10M.direction}    /  Speed: ${datasery.wind10M.direction}  "
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  options: CarouselOptions(
                                      enlargeCenterPage: true,
                                      enableInfiniteScroll: false,
                                      //
                                      autoPlay: true),
                                ),
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
                        return Column(
                          children: [
                            const Center(
                                child: Text(
                              "Get your Current Weather",
                              style: TextStyle(
                                  color: Color(0xFF010035),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                            Center(
                                // ignore: sized_box_for_whitespace
                                child: Expanded(
                              // ignore: sized_box_for_whitespace
                              child: Container(
                                child: const FlareActor(
                                  "assets/WorldSpin.flr",
                                  fit: BoxFit.contain,
                                  animation: "roll",
                                ),
                                height: 200,
                                width: 200,
                              ),
                            )),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
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
              ],
            ),
          ),
        ));
  }
}
