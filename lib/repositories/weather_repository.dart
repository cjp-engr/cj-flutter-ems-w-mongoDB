import 'package:ems_app/exceptions/custom_exception.dart';
import 'package:ems_app/models/model_custom_error.dart';
import 'package:ems_app/services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Map<String, dynamic>?> fetchWeather() async {
    try {
      final weather = await weatherApiServices.getWeather('Manila');
      return weather;
    } on CustomException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }
}
