part of 'employees_bloc.dart';

abstract class EmployeesEvent extends Equatable {
  const EmployeesEvent();

  @override
  List<Object> get props => [];
}

class FetchAllEmployeesEvent extends EmployeesEvent {}

class FetchIdEvent extends EmployeesEvent {
  final String id;
  const FetchIdEvent({
    required this.id,
  });
}
