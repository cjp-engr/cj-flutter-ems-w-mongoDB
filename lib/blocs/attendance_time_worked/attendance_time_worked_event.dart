part of 'attendance_time_worked_bloc.dart';

abstract class AttendanceTimeWorkedEvent extends Equatable {
  const AttendanceTimeWorkedEvent();

  @override
  List<Object> get props => [];
}

class GetTimeWorkedEvent extends AttendanceTimeWorkedEvent {
  final Duration duration;
  const GetTimeWorkedEvent({
    required this.duration,
  });
}

class TestEvent extends AttendanceTimeWorkedEvent {
  final String id;
  final DateTime workedDate;
  const TestEvent({
    required this.id,
    required this.workedDate,
  });
}
