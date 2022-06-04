part of 'attendance_today_bloc.dart';

abstract class AttendanceTodayEvent extends Equatable {
  const AttendanceTodayEvent();

  @override
  List<Object> get props => [];
}

class EnterAttendancePinEvent extends AttendanceTodayEvent {
  final String enteredPIN;
  const EnterAttendancePinEvent({
    required this.enteredPIN,
  });
}

class ClockInClickedEvent extends AttendanceTodayEvent {}

class ClockInSuccessfulEvent extends AttendanceTodayEvent {
  final Employee employee;
  const ClockInSuccessfulEvent({
    required this.employee,
  });
}

class ClockOutClickedEvent extends AttendanceTodayEvent {}

class ClockOutSuccessfulEvent extends AttendanceTodayEvent {
  final Employee employee;
  const ClockOutSuccessfulEvent({
    required this.employee,
  });
}

class SubmitWorkedTimeTodayEvent extends AttendanceTodayEvent {
  final Attendance attendance;
  const SubmitWorkedTimeTodayEvent({
    required this.attendance,
  });
}

class ClearDetailsTodayEvent extends AttendanceTodayEvent {}
