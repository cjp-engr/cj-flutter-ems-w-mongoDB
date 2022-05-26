import 'dart:async';
import 'dart:convert';

import 'package:ems_app/constants/constants.dart';
import 'package:ems_app/models/attendance.dart';
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
        }),
      );

      if (response.statusCode == 201) {
        Attendance.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      rethrow;
    }
  }
}
