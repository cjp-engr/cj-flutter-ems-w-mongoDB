part of 'employees_bloc.dart';

enum EmployeesListStatus {
  initial,
  loading,
  loaded,
  error,
}

enum EmployeeStatus {
  initial,
  loading,
  loaded,
  error,
}

class EmployeesState extends Equatable {
  final List<Employee> employeesList;
  final Employee employeeDetails;
  final EmployeesListStatus employeesListStatus;
  final EmployeeStatus employeeStatus;
  final CustomError customError;
  const EmployeesState({
    required this.employeesList,
    required this.employeeDetails,
    required this.employeesListStatus,
    required this.employeeStatus,
    required this.customError,
  });

  @override
  List<Object?> get props => [
        employeesList,
        employeeDetails,
        employeesListStatus,
        employeeStatus,
        customError,
      ];

  factory EmployeesState.initial() {
    return EmployeesState(
      employeesList: const [],
      employeeDetails: Employee.initial(),
      employeesListStatus: EmployeesListStatus.initial,
      employeeStatus: EmployeeStatus.initial,
      customError: const CustomError(),
    );
  }

  @override
  String toString() {
    return 'EmployeesState(employeesList: $employeesList, employeeDetails: $employeeDetails, employeesListStatus: $employeesListStatus, employeeStatus: $employeeStatus, customError: $customError)';
  }

  EmployeesState copyWith({
    List<Employee>? employeesList,
    Employee? employeeDetails,
    EmployeesListStatus? employeesListStatus,
    EmployeeStatus? employeeStatus,
    CustomError? customError,
  }) {
    return EmployeesState(
      employeesList: employeesList ?? this.employeesList,
      employeeDetails: employeeDetails ?? this.employeeDetails,
      employeesListStatus: employeesListStatus ?? this.employeesListStatus,
      employeeStatus: employeeStatus ?? this.employeeStatus,
      customError: customError ?? this.customError,
    );
  }
}
