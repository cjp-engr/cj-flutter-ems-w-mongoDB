import 'dart:convert';

import 'package:ems_app/constants/constants.dart';
import 'package:ems_app/models/country_codes.dart';
import 'package:http/http.dart' as http;

class CountryCodeApiServices {
  final http.Client httpClient;
  CountryCodeApiServices({
    required this.httpClient,
  });

  Future<List<CountryCodes>?> getCountryCode() async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kCountryCodeHost,
      path: '/countries',
    );

    try {
      final http.Response response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200) {
        throw Exception('response.statusCode != 200');
      }

      final ccJson = json.decode(utf8.decode(response.bodyBytes))['countries'];
      List<CountryCodes> results =
          (ccJson as List).map((e) => CountryCodes.fromJson(e)).toList();

      return results;
    } catch (e) {
      rethrow;
    }
  }
}
