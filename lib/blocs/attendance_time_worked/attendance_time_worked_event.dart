part of 'attendance_time_worked_bloc.dart';

abstract class AttendanceTimeWorkedEvent extends Equatable {
  const AttendanceTimeWorkedEvent();

  @override
  List<Object> get props => [];
}

class DisplayTimeWorkedEvent extends AttendanceTimeWorkedEvent {}
