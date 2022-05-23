part of 'employee_view_hours_bloc.dart';

abstract class EmployeeViewHoursEvent extends Equatable {
  const EmployeeViewHoursEvent();

  @override
  List<Object> get props => [];
}

class EnterStartTimeEvent extends EmployeeViewHoursEvent {
  final String startTimeEntered;
  const EnterStartTimeEvent({
    required this.startTimeEntered,
  });
}

class EnterEndTimeEvent extends EmployeeViewHoursEvent {
  final String endTimeEntered;
  const EnterEndTimeEvent({
    required this.endTimeEntered,
  });
}
