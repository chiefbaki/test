abstract class WeatherEvent {}

class GetWeather extends WeatherEvent {}

class Increment extends WeatherEvent {
  final int counter;
  final bool isDark;
  Increment(this.counter, this.isDark);
}

class Decrement extends WeatherEvent {
  final int counter;
  final bool isDark;
  Decrement(this.counter, this.isDark);
}
