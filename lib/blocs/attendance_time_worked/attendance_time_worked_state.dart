part of 'attendance_time_worked_bloc.dart';

class AttendanceTimeWorkedState extends Equatable {
  final String hours;
  final String minutes;

  const AttendanceTimeWorkedState({
    required this.hours,
    required this.minutes,
  });

  factory AttendanceTimeWorkedState.initial() {
    return const AttendanceTimeWorkedState(
      hours: '0',
      minutes: '0',
    );
  }

  @override
  List<Object?> get props => [
        hours,
        minutes,
      ];

  AttendanceTimeWorkedState copyWith({
    String? hours,
    String? minutes,
  }) {
    return AttendanceTimeWorkedState(
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
    );
  }

  @override
  String toString() =>
      'AttendanceTimeWorkedState(hours: $hours, minutes: $minutes)';
}
