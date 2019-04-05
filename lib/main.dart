import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_weather/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_weather/screens/screens.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();

  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(App(weatherRepository: weatherRepository));
}

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Weather",
      home: Weather(
        weatherRepository: weatherRepository,
      ),
    );
  }
}