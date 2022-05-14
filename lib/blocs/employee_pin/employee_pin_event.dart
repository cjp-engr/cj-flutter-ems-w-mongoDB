part of 'employee_pin_bloc.dart';

abstract class EmployeePinEvent extends Equatable {
  const EmployeePinEvent();

  @override
  List<Object> get props => [];
}

class EnterEmployeePinEvent extends EmployeePinEvent {
  final String enteredPIN;
  const EnterEmployeePinEvent({
    required this.enteredPIN,
  });
}

class EnterClickedEvent extends EmployeePinEvent {}
