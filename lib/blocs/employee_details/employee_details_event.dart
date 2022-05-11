part of 'employee_details_bloc.dart';

abstract class EmployeeDetailsEvent extends Equatable {
  const EmployeeDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchIdEvent extends EmployeeDetailsEvent {
  final String id;
  const FetchIdEvent({
    required this.id,
  });
}

class SubmitEmployeeDetailsEvent extends EmployeeDetailsEvent {
  final Employee emp;
  const SubmitEmployeeDetailsEvent({
    required this.emp,
  });
}
