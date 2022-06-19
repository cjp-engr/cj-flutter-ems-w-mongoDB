import 'dart:async';
import 'dart:convert';

import '../../constants/constants.dart';
import 'package:http/http.dart' as http;

class WeatherApiServices {
  final http.Client httpClient;
  WeatherApiServices({
    required this.httpClient,
  });

  Future<Map<String, dynamic>?> getWeather(String city) async {
    final Uri uri = Uri(
        scheme: 'https',
        host: kWeatherHost,
        path: '/data/2.5/weather',
        queryParameters: {
          'q': city,
          'appid': openWeatherApiKey,
          'units': openWeatherUnit,
        });

    try {
      final http.Response response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200) {
        throw Exception('response.statusCode != 200');
      }

      //final weatherJson = json.decode(utf8.decode(response.bodyBytes));
      Map<String, dynamic> results = Map<String, dynamic>.from(
          json.decode(utf8.decode(response.bodyBytes)));

      return results;
    } catch (e) {
      rethrow;
    }
  }
}
