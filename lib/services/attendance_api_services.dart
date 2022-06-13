import 'dart:async';
import 'dart:convert';

import '../../constants/constants.dart';
import '../../models/attendance.dart';
import 'package:http/http.dart' as http;

class AttendanceApiServices {
  final http.Client httpClient;
  AttendanceApiServices({
    required this.httpClient,
  });

  Future<void> addAttendance(Attendance a) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kEmployeesHost,
      path: '/attendance',
    );
    try {
      String workedHrs = ((a.clockout! - a.clockin!) / 3600000.0).toString();
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'uniqueId': a.uniqueId,
          'firstName': a.firstName,
          'lastName': a.lastName,
          'employeeId': a.employeeId,
          'clockin': a.clockin,
          'clockout': a.clockout,
          'workDate': a.workDate,
          'status': a.status,
          'hourlyRate': a.hourlyRate,
          'workedHours': workedHrs,
        }),
      );

      if (response.statusCode == 201) {
        Attendance.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Attendance>?> getAttendance(
    String uniqueId,
    String workDate,
  ) async {
    final Uri uri = Uri(
        scheme: 'https',
        host: kEmployeesHost,
        path: '/attendance',
        queryParameters: {
          'uniqueId': uniqueId,
          'workDate': workDate,
        });

    try {
      final http.Response response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200) {
        throw Exception('response.statusCode != 200');
      }

      final attJson =
          json.decode(utf8.decode(response.bodyBytes))['attendance'];
      List<Attendance> results =
          (attJson as List).map((e) => Attendance.fromJson(e)).toList();

      return results;
    } catch (e) {
      rethrow;
    }
  }

  Future<Attendance?> updateAttendance(
    Attendance a,
    String id,
  ) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kEmployeesHost,
      path: '/attendance/$id',
    );
    String workedHrs = ((a.clockout! - a.clockin!) / 3600000.0).toString();
    final response = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'clockin': a.clockin,
        'clockout': a.clockout,
        'status': a.status,
        'workedHours': workedHrs,
      }),
    );

    if (response.statusCode == 200) {
      return Attendance.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update album.');
    }
  }

  Future<Attendance?> updateTodayAttendance(
    String uniqueId,
    String workDate,
    Attendance a,
  ) async {
    String workedHrs = ((a.clockout! - a.clockin!) / 3600000.0).toString();
    final Uri uri = Uri(
        scheme: 'https',
        host: kEmployeesHost,
        path: '/attendance',
        queryParameters: {
          'uniqueId': uniqueId,
          'workDate': workDate,
          'status': '1',
          'clockout': '-1',
        });

    final response = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'clockout': a.clockout,
        'status': a.status,
        'workedHours': workedHrs,
      }),
    );

    if (response.statusCode == 200) {
      return Attendance.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update album.');
    }
  }

  Future<Attendance?> deleteAttendance(String id) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kEmployeesHost,
      path: '/attendance/$id',
    );

    final http.Response response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Attendance.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete album.');
    }
  }
}
