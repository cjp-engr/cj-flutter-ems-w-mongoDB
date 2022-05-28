part of 'attendance_bloc.dart';

enum AttendanceStatus {
  initial,
  adding,
  added,
  clear,
  reading,
  read,
  updating,
  updated,
  deleting,
  deleted,
  error,
}

class AttendanceState extends Equatable {
  final String uniqueId;
  final String firstName;
  final String lastName;
  final String employeeId;
  final DateTime clockin;
  final DateTime clockout;
  final DateTime workDate;
  final int status;
  final AttendanceStatus attStatus;
  final List<Attendance> attendanceList;
  final CustomError customError;
  const AttendanceState({
    required this.uniqueId,
    required this.firstName,
    required this.lastName,
    required this.employeeId,
    required this.clockin,
    required this.clockout,
    required this.workDate,
    required this.status,
    required this.attStatus,
    required this.attendanceList,
    required this.customError,
  });

  factory AttendanceState.initial() {
    return AttendanceState(
      uniqueId: '',
      firstName: '',
      lastName: '',
      employeeId: '',
      clockin: DateTime(1970, 1, 1),
      clockout: DateTime(1970, 1, 1),
      workDate: DateTime.now(),
      status: 0,
      attStatus: AttendanceStatus.initial,
      attendanceList: const [],
      customError: const CustomError(),
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
        attStatus,
        attendanceList,
        customError,
      ];

  AttendanceState copyWith({
    String? uniqueId,
    String? firstName,
    String? lastName,
    String? employeeId,
    DateTime? clockin,
    DateTime? clockout,
    DateTime? workDate,
    int? status,
    AttendanceStatus? attStatus,
    List<Attendance>? attendanceList,
    CustomError? customError,
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
      attStatus: attStatus ?? this.attStatus,
      attendanceList: attendanceList ?? this.attendanceList,
      customError: customError ?? this.customError,
    );
  }

  @override
  String toString() {
    return 'AttendanceState(uniqueId: $uniqueId, firstName: $firstName, lastName: $lastName, employeeId: $employeeId, clockin: $clockin, clockout: $clockout, workDate: $workDate, status: $status, attStatus: $attStatus, attendanceList: $attendanceList, customError: $customError)';
  }
}
