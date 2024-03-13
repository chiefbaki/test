import 'package:dio/dio.dart';
import 'package:test_flutter/data/weather_dto.dart';

class WeatherRep {
  final Dio dio;
  WeatherRep({required this.dio});
  Future<WeatherDto> getWeather(
      {String lat = "42.8746", String lng = "74.5698"}) async {
    final Response response = await dio.get(
        "https://api.openweathermap.org/data/2.5/weather?lat=42.8746&lon=74.5698&appid=82424742061e498492facc25c51dd408");
    print("print");
    return WeatherDto.fromJson(response.data);
  }
}
