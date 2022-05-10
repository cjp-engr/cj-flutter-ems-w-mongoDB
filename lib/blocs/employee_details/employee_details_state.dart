part of 'employee_details_bloc.dart';

enum EmployeeStatus {
  initial,
  loading,
  loaded,
  error,
}

class EmployeeDetailsState extends Equatable {
  final Employee employeeDetails;
  final EmployeeStatus employeeStatus;
  final CustomError customError;

  const EmployeeDetailsState({
    required this.employeeDetails,
    required this.employeeStatus,
    required this.customError,
  });

  @override
  List<Object?> get props => [
        employeeDetails,
        employeeStatus,
        customError,
      ];

  factory EmployeeDetailsState.initial() {
    return EmployeeDetailsState(
      employeeDetails: Employee.initial(),
      employeeStatus: EmployeeStatus.initial,
      customError: const CustomError(),
    );
  }

  @override
  String toString() =>
      'EmployeesState(employeeDetails: $employeeDetails, employeeStatus: $employeeStatus, customError: $customError)';

  EmployeeDetailsState copyWith({
    Employee? employeeDetails,
    EmployeeStatus? employeeStatus,
    CustomError? customError,
  }) {
    return EmployeeDetailsState(
      employeeDetails: employeeDetails ?? this.employeeDetails,
      employeeStatus: employeeStatus ?? this.employeeStatus,
      customError: customError ?? this.customError,
    );
  }
}
