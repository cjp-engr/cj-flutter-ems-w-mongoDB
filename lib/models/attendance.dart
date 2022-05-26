import 'package:equatable/equatable.dart';

class Attendance extends Equatable {
  final String? uniqueId;
  final String? firstName;
  final String? lastName;
  final String? employeeId;
  final int? clockin;
  final int? clockout;
  final int? workDate;
  final int? status;
  const Attendance({
    this.uniqueId,
    this.firstName,
    this.lastName,
    this.employeeId,
    this.clockin,
    this.clockout,
    this.workDate,
    this.status,
  });

  Attendance.fromJson(Map<String, dynamic> json)
      : uniqueId = json['uniqueId'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        employeeId = json['employeeId'],
        clockin = json['clockin'],
        clockout = json['clockout'],
        workDate = json['workDate'],
        status = json['status'];

  factory Attendance.initial() => const Attendance();

  @override
  List<Object?> get props {
    return [
      uniqueId,
      firstName,
      lastName,
      employeeId,
      clockin,
      clockout,
      workDate,
      status,
    ];
  }

  @override
  String toString() {
    return 'Attendance(uniqueId: $uniqueId, firstName: $firstName, lastName: $lastName, employeeId: $employeeId, clockin: $clockin, clockout: $clockout, workDate: $workDate, status: $status)';
  }
}
