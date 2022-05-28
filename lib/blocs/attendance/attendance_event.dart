part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class GetEmployeeDetailsEvent extends AttendanceEvent {
  final String uniqueId;
  final String firstName;
  final String lastName;
  final String employeeId;

  const GetEmployeeDetailsEvent({
    required this.uniqueId,
    required this.firstName,
    required this.lastName,
    required this.employeeId,
  });
}

class GetSelectedDateEvent extends AttendanceEvent {
  final DateTime selectedDate;

  const GetSelectedDateEvent({
    required this.selectedDate,
  });
}

class GetWorkedStartTimeEvent extends AttendanceEvent {
  final DateTime startTime;

  const GetWorkedStartTimeEvent({
    required this.startTime,
  });
}

class GetWorkedEndTimeEvent extends AttendanceEvent {
  final DateTime endTime;

  const GetWorkedEndTimeEvent({
    required this.endTime,
  });
}

class AddWorkedTimeEvent extends AttendanceEvent {}

class SubmitWorkedTimeEvent extends AttendanceEvent {
  final Attendance attendance;
  const SubmitWorkedTimeEvent({
    required this.attendance,
  });
}

class ClearDetailsEvent extends AttendanceEvent {}

class ClearAddTimeFieldsEvent extends AttendanceEvent {}
