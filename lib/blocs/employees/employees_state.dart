part of 'employees_bloc.dart';

enum EmployeesStatus {
  initial,
  loading,
  loaded,
  error,
}

class EmployeesState extends Equatable {
  final List<Employee> employeesList;
  final EmployeesStatus employeesStatus;
  final CustomError customError;
  const EmployeesState({
    required this.employeesList,
    required this.employeesStatus,
    required this.customError,
  });

  @override
  List<Object?> get props => [
        employeesList,
        employeesStatus,
        customError,
      ];

  factory EmployeesState.initial() {
    return const EmployeesState(
      employeesList: [],
      employeesStatus: EmployeesStatus.initial,
      customError: CustomError(),
    );
  }

  @override
  String toString() =>
      'EmployeesState(employeesList: $employeesList, employeesStatus: $employeesStatus, customError: $customError)';

  EmployeesState copyWith({
    List<Employee>? employeesList,
    EmployeesStatus? employeesStatus,
    CustomError? customError,
  }) {
    return EmployeesState(
      employeesList: employeesList ?? this.employeesList,
      employeesStatus: employeesStatus ?? this.employeesStatus,
      customError: customError ?? this.customError,
    );
  }
}
