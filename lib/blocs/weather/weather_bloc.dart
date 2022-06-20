import 'package:bloc/bloc.dart';
import 'package:ems_app/constants/constants.dart';
import 'package:ems_app/models/weather.dart';
import 'package:ems_app/repositories/weather_repository.dart';
import 'package:equatable/equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository})
      : super(WeatherState.initial()) {
    on<GetWeatherEvent>((event, emit) async {
      emit(state.copyWith(weatherStatus: WeatherStatus.loading));
      Map<String, dynamic>? a = await weatherRepository.fetchWeather();
      final json = Weather.fromJson(a!);
      emit(
        state.copyWith(
          weather: Weather(
            description: json.description,
            icon: openWeatherIcon + json.icon + '@2x.png',
            temp: json.temp,
            tempMin: json.tempMin,
            tempMax: json.tempMax,
            name: json.name,
            country: json.country,
            lastUpdated: json.lastUpdated,
          ),
          weatherStatus: WeatherStatus.loaded,
        ),
      );
    });
  }
}
