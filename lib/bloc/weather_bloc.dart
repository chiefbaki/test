import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/bloc/weather_event.dart';
import 'package:test_flutter/bloc/weather_state.dart';
import 'package:test_flutter/data/weather_dto.dart';
import 'package:test_flutter/rep/weather_rep.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required this.repository}) : super(WeatherInitial()) {
    on<GetWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final WeatherDto model = await repository.getWeather();
        emit(WeatherSuccess(model: model));
      } catch (e) {
        emit(WeatherError(error: e.toString()));
      }
    });
  }
  final WeatherRep repository;
}
