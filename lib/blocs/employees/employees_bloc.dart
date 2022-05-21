import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ems_app/blocs/blocs.dart';

import 'package:ems_app/models/employee.dart';
import 'package:ems_app/models/model_custom_error.dart';
import 'package:ems_app/repositories/employee_repository.dart';
import 'package:equatable/equatable.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  late final StreamSubscription empDetailsSubscription;
  final EmployeeRepository employeeRepository;
  final EmployeeDetailsBloc empDetailsBloc;

  EmployeesBloc({
    required this.employeeRepository,
    required this.empDetailsBloc,
  }) : super(EmployeesState.initial()) {
    empDetailsSubscription =
        empDetailsBloc.stream.listen((EmployeeDetailsState empDetailsState) {
      if (empDetailsState.employeeStatus == EmployeeStatus.added ||
          empDetailsState.employeeStatus == EmployeeStatus.updated ||
          empDetailsState.employeeStatus == EmployeeStatus.deleted) {
        add(FetchAllEmployeesEvent());
      }
    });
    on<FetchAllEmployeesEvent>(_fetchAllEmployees);
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

  @override
  Future<void> close() {
    empDetailsSubscription.cancel();
    return super.close();
  }
}
