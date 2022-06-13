part of 'payroll_bloc.dart';

abstract class PayrollEvent extends Equatable {
  const PayrollEvent();

  @override
  List<Object> get props => [];
}

class SetInitialDatesEvent extends PayrollEvent {}

class GetDateFromEvent extends PayrollEvent {
  final DateTime selectedDate;
  const GetDateFromEvent({
    required this.selectedDate,
  });
}

class GetDateToEvent extends PayrollEvent {
  final DateTime selectedDate;
  const GetDateToEvent({
    required this.selectedDate,
  });
}

class GetEmployeeUniqueIdPR extends PayrollEvent {
  final String uniqueId;
  const GetEmployeeUniqueIdPR({
    required this.uniqueId,
  });
}
