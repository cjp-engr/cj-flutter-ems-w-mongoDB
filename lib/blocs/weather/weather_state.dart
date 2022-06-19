part of 'weather_bloc.dart';

enum WeatherStatus {
  loading,
  loaded,
  error,
  initial,
}

class WeatherState extends Equatable {
  final Weather weather;
  final WeatherStatus weatherStatus;
  const WeatherState({
    required this.weather,
    required this.weatherStatus,
  });

  factory WeatherState.initial() {
    return WeatherState(
        weather: Weather.initial(), weatherStatus: WeatherStatus.initial);
  }
  @override
  List<Object?> get props => [
        weather,
        weatherStatus,
      ];

  WeatherState copyWith({
    Weather? weather,
    WeatherStatus? weatherStatus,
  }) {
    return WeatherState(
      weather: weather ?? this.weather,
      weatherStatus: weatherStatus ?? this.weatherStatus,
    );
  }

  @override
  String toString() =>
      'WeatherState(weather: $weather, weatherStatus: $weatherStatus)';
}
