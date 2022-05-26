part of 'attendance_bloc.dart';

class AttendanceState extends Equatable {
  final String uniqueId;
  final String firstName;
  final String lastName;
  final String employeeId;
  final int clockin;
  final int clockout;
  final DateTime workDate;
  final int status;
  const AttendanceState({
    required this.uniqueId,
    required this.firstName,
    required this.lastName,
    required this.employeeId,
    required this.clockin,
    required this.clockout,
    required this.workDate,
    required this.status,
  });

  factory AttendanceState.initial() {
    return AttendanceState(
      uniqueId: '',
      firstName: '',
      lastName: '',
      employeeId: '',
      clockin: 0,
      clockout: 0,
      workDate: DateTime.now(),
      status: 0,
    );
  }

  @override
  List<Object?> get props => [
        uniqueId,
        firstName,
        lastName,
        employeeId,
        clockin,
        clockout,
        workDate,
        status,
      ];

  AttendanceState copyWith({
    String? uniqueId,
    String? firstName,
    String? lastName,
    String? employeeId,
    int? clockin,
    int? clockout,
    DateTime? workDate,
    int? status,
  }) {
    return AttendanceState(
      uniqueId: uniqueId ?? this.uniqueId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      employeeId: employeeId ?? this.employeeId,
      clockin: clockin ?? this.clockin,
      clockout: clockout ?? this.clockout,
      workDate: workDate ?? this.workDate,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'AttendanceState(uniqueId: $uniqueId, firstName: $firstName, lastName: $lastName, employeeId: $employeeId, clockin: $clockin, clockout: $clockout, workDate: $workDate, status: $status)';
  }
}
