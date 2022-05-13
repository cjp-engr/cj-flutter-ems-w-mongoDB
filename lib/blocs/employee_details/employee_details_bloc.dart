import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ems_app/models/employee.dart';
import 'package:ems_app/models/model_custom_error.dart';
import 'package:ems_app/repositories/employee_repository.dart';
import 'package:equatable/equatable.dart';

part 'employee_details_event.dart';
part 'employee_details_state.dart';

class EmployeeDetailsBloc
    extends Bloc<EmployeeDetailsEvent, EmployeeDetailsState> {
  final EmployeeRepository employeeRepository;
  EmployeeDetailsBloc({
    required this.employeeRepository,
  }) : super(EmployeeDetailsState.initial()) {
    on<FetchIdEvent>(_fetchId);
    on<SubmitEmployeeDetailsEvent>(_addEmployee);
  }

  FutureOr<void> _fetchId(
    FetchIdEvent event,
    Emitter<EmployeeDetailsState> emit,
  ) async {
    if (event.id == "addingNewEmployee") {
      emit(state.copyWith(
        employeeStatus: EmployeeStatus.adding,
      ));
      log(event.id);
      return;
    }
    try {
      emit(state.copyWith(
        employeeStatus: EmployeeStatus.reading,
      ));
      final Employee employee =
          await employeeRepository.fetchEmployeeById(event.id);
      emit(state.copyWith(
        employeeDetails: employee,
        employeeStatus: EmployeeStatus.read,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        employeeStatus: EmployeeStatus.error,
        customError: e,
      ));
    }
  }

  FutureOr<void> _addEmployee(
    SubmitEmployeeDetailsEvent event,
    Emitter<EmployeeDetailsState> emit,
  ) async {
    try {
      await employeeRepository.addNewEmployee(event.emp);
      emit(state.copyWith(employeeStatus: EmployeeStatus.added));
    } on CustomError catch (e) {
      emit(state.copyWith(
        employeeStatus: EmployeeStatus.error,
        customError: e,
      ));
    }
  }
}
