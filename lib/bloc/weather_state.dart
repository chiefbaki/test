import 'package:test_flutter/data/weather_dto.dart';

abstract class WeatherState{

}

class WeatherInitial extends WeatherState{}

class WeatherLoading extends WeatherState{}
class WeatherSuccess extends WeatherState{
  final WeatherDto? model;
  final int? counter;
  WeatherSuccess({this.model, this.counter});
}

class WeatherError extends WeatherState{
  final String error;
  WeatherError({required this.error});
}