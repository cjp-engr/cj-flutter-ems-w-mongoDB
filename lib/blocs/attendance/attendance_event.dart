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

class ClearDetailsEvent extends AttendanceEvent {}
