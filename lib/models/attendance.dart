import 'package:equatable/equatable.dart';

class Attendance extends Equatable {
  final String? id;
  final String? uniqueId;
  final String? firstName;
  final String? lastName;
  final String? employeeId;
  final int? clockin;
  final int? clockout;
  final int? workDate;
  final int? status;
  final double? hourlyRate;

  const Attendance({
    this.id,
    this.uniqueId,
    this.firstName,
    this.lastName,
    this.employeeId,
    this.clockin,
    this.clockout,
    this.workDate,
    this.status,
    this.hourlyRate,
  });

  Attendance.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        uniqueId = json['uniqueId'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        employeeId = json['employeeId'],
        clockin = json['clockin'],
        clockout = json['clockout'],
        workDate = json['workDate'],
        status = json['status'],
        hourlyRate =
            json['hourlyRate'] == null ? 0.0 : json['hourlyRate'].toDouble();

  factory Attendance.initial() => const Attendance(
        id: '',
        uniqueId: '',
        firstName: '',
        lastName: '',
        employeeId: '',
        clockin: 0,
        clockout: 0,
        workDate: 0,
        status: 0,
        hourlyRate: 0,
      );

  @override
  List<Object?> get props {
    return [
      id,
      uniqueId,
      firstName,
      lastName,
      employeeId,
      clockin,
      clockout,
      workDate,
      status,
      hourlyRate,
    ];
  }

  @override
  String toString() {
    return 'Attendance(id: $id, uniqueId: $uniqueId, firstName: $firstName, lastName: $lastName, employeeId: $employeeId, clockin: $clockin, clockout: $clockout, workDate: $workDate, status: $status, hourlyRate: $hourlyRate)';
  }
}
