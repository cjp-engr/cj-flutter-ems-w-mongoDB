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
    on<SubmitEmployeeDetailsEvent>(_addOrUpdateEmployee);
  }

  FutureOr<void> _fetchId(
    FetchIdEvent event,
    Emitter<EmployeeDetailsState> emit,
  ) async {
    if (event.id == "addingNewEmployee") {
      emit(state.copyWith(
        employeeDetails: Employee.initial(),
        employeeStatus: EmployeeStatus.adding,
      ));
      log("addingNewEmployee");
      return;
    }
    if (event.id == "") {
      emit(state.copyWith(
        employeeDetails: Employee.initial(),
        employeeStatus: EmployeeStatus.clear,
      ));
      return;
    }
    try {
      emit(state.copyWith(
        employeeStatus: EmployeeStatus.reading,
      ));
      final Employee? employee =
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

  FutureOr<void> _addOrUpdateEmployee(
    SubmitEmployeeDetailsEvent event,
    Emitter<EmployeeDetailsState> emit,
  ) async {
    try {
      if (state.employeeStatus == EmployeeStatus.adding) {
        await employeeRepository.addNewEmployee(event.emp);
        emit(state.copyWith(employeeStatus: EmployeeStatus.added));
      } else if (state.employeeStatus == EmployeeStatus.read) {
        await employeeRepository.updateEmployee(
          event.emp,
          state.employeeDetails.id!,
        );
        emit(state.copyWith(employeeStatus: EmployeeStatus.updated));
      }
    } on CustomError catch (e) {
      emit(state.copyWith(
        employeeStatus: EmployeeStatus.error,
        customError: e,
      ));
    }
  }

  // FutureOr<void> _updateEmployee(
  //   SubmitEmployeeDetailsEvent event,
  //   Emitter<EmployeeDetailsState> emit,
  // ) async {
  //   try {
  //     await employeeRepository.updateEmployee(event.emp, event.emp.id!);
  //     emit(state.copyWith(employeeStatus: EmployeeStatus.updated));
  //   } on CustomError catch (e) {
  //     emit(state.copyWith(
  //       employeeStatus: EmployeeStatus.error,
  //       customError: e,
  //     ));
  //   }
  // }
}
