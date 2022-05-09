import 'dart:convert';

import 'package:ems_app/constants/constants.dart';
import 'package:ems_app/models/employee.dart';
import 'package:http/http.dart' as http;

class EmployeeApiServices {
  final http.Client httpClient;
  EmployeeApiServices({
    required this.httpClient,
  });

  Future<List<Employee>?> getEmployees() async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kEmployeesHost,
      path: '/employee',
    );

    try {
      final http.Response response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200) {
        throw Exception('response.statusCode != 200');
      }

      final empJson = json.decode(utf8.decode(response.bodyBytes))['data'];
      List<Employee> results =
          (empJson as List).map((e) => Employee.fromJson(e)).toList();

      return results;
    } catch (e) {
      rethrow;
    }
  }
}
