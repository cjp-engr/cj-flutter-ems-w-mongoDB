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

class ClockOutClickedEvent extends AttendanceTodayEvent {}
