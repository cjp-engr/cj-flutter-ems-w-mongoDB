import 'dart:async';
import 'dart:convert';

import 'package:ems_app/models/payroll.dart';

import '../../constants/constants.dart';
import '../../models/attendance.dart';
import 'package:http/http.dart' as http;

class PayrollApiServices {
  final http.Client httpClient;
  PayrollApiServices({
    required this.httpClient,
  });

  Future<List<Payroll>?> getPayroll(
    String uniqueId,
    String lteDate,
    String gteDate,
  ) async {
    final Uri uri = Uri(
        scheme: 'https',
        host: kEmployeesHost,
        path: '/attendance/payroll',
        queryParameters: {
          'uniqueId': uniqueId,
          'lteDate': lteDate,
          'gteDate': gteDate,
        });

    try {
      final http.Response response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200) {
        throw Exception('response.statusCode != 200');
      }

      final attJson = json.decode(utf8.decode(response.bodyBytes))['payroll'];
      List<Payroll> results =
          (attJson as List).map((e) => Payroll.fromJson(e)).toList();

      return results;
    } catch (e) {
      rethrow;
    }
  }
}
