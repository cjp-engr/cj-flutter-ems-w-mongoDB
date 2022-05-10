part of 'employees_bloc.dart';

enum EmployeesListStatus {
  initial,
  loading,
  loaded,
  error,
}

class EmployeesState extends Equatable {
  final List<Employee> employeesList;
  final EmployeesListStatus employeesListStatus;
  final CustomError customError;
  const EmployeesState({
    required this.employeesList,
    required this.employeesListStatus,
    required this.customError,
  });

  @override
  List<Object?> get props => [
        employeesList,
        employeesListStatus,
        customError,
      ];

  factory EmployeesState.initial() {
    return const EmployeesState(
      employeesList: [],
      employeesListStatus: EmployeesListStatus.initial,
      customError: CustomError(),
    );
  }

  @override
  String toString() =>
      'EmployeesState(employeesList: $employeesList, employeesListStatus: $employeesListStatus, customError: $customError)';

  EmployeesState copyWith({
    List<Employee>? employeesList,
    EmployeesListStatus? employeesListStatus,
    CustomError? customError,
  }) {
    return EmployeesState(
      employeesList: employeesList ?? this.employeesList,
      employeesListStatus: employeesListStatus ?? this.employeesListStatus,
      customError: customError ?? this.customError,
    );
  }
}
