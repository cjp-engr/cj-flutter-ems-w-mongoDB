import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ems_app/models/employee.dart';
import 'package:ems_app/models/model_custom_error.dart';
import 'package:ems_app/repositories/employee_repository.dart';
import 'package:equatable/equatable.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  final EmployeeRepository employeeRepository;
  EmployeesBloc({
    required this.employeeRepository,
  }) : super(EmployeesState.initial()) {
    on<FetchAllEmployeesEvent>(_fetchAllEmployees);
    on<FetchIdEvent>(_fetchId);
  }

  FutureOr<void> _fetchAllEmployees(
    FetchAllEmployeesEvent event,
    Emitter<EmployeesState> emit,
  ) async {
    emit(state.copyWith(employeesListStatus: EmployeesListStatus.loading));
    try {
      final List<Employee>? empList =
          await employeeRepository.fetchEmployeesList();
      emit(state.copyWith(
        employeesList: empList,
        employeesListStatus: EmployeesListStatus.loaded,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        employeesListStatus: EmployeesListStatus.error,
        customError: e,
      ));
    }
  }

  FutureOr<void> _fetchId(
    FetchIdEvent event,
    Emitter<EmployeesState> emit,
  ) async {
    emit(state.copyWith(employeeStatus: EmployeeStatus.loading));

    try {
      final Employee employee =
          await employeeRepository.fetchEmployeeById(event.id);

      emit(state.copyWith(
          employeeDetails: employee, employeeStatus: EmployeeStatus.loaded));
    } on CustomError catch (e) {
      emit(
          state.copyWith(employeeStatus: EmployeeStatus.error, customError: e));
    }
  }
}
