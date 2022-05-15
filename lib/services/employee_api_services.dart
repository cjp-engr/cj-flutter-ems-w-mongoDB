import 'dart:async';
import 'dart:convert';
import 'dart:developer' as loggg;

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

      final empJson = json.decode(utf8.decode(response.bodyBytes))['employees'];
      List<Employee> results =
          (empJson as List).map((e) => Employee.fromJson(e)).toList();

      return results;
    } catch (e) {
      rethrow;
    }
  }

  Future<Employee> getEmployee(String id) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kEmployeesHost,
      path: '/employee/$id',
    );

    try {
      final http.Response response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200) {
        throw Exception('response.statusCode != 200');
      }

      final empJson = json.decode(utf8.decode(response.bodyBytes))['employees'];
      final Employee employee = Employee.fromJson(empJson);
      return employee;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addEmployee(Employee e) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kEmployeesHost,
      path: '/employee',
    );
    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'firstName': e.firstName,
          'lastName': e.lastName,
          'email': e.email,
          'countryCode': e.countryCode,
          'phoneNumber': e.phoneNumber,
          'employeeId': e.employeeId,
          'jobRole': e.jobRole,
          'payType': e.payType,
          'hourlyRate': e.hourlyRate,
          'weeklyHours': e.weeklyHours,
          'pin': e.pin
        }),
      );

      if (response.statusCode == 201) {
        Employee.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<Employee?> getEmployeePin(String pin) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kEmployeesHost,
      path: '/employee',
      queryParameters: {
        'pin': pin,
      },
    );

    try {
      final http.Response response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200) {
        throw Exception('response.statusCode != 200');
      }

      final empJson = json.decode(utf8.decode(response.bodyBytes))['employees'];
      List<Employee?> results =
          (empJson as List).map((e) => Employee.fromJson(e)).toList();
      if (results.isNotEmpty) {
        Employee? employee = results[0];
        return employee;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
