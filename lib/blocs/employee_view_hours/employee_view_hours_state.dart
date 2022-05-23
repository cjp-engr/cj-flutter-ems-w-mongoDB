part of 'employee_view_hours_bloc.dart';

class EmployeeViewHoursState extends Equatable {
  final String enteredStartTime;
  final String enteredEndTime;
  const EmployeeViewHoursState({
    required this.enteredStartTime,
    required this.enteredEndTime,
  });

  factory EmployeeViewHoursState.initial() {
    return const EmployeeViewHoursState(
      enteredStartTime: 'START',
      enteredEndTime: 'END',
    );
  }
  @override
  List<Object?> get props => [
        enteredStartTime,
        enteredEndTime,
      ];

  @override
  String toString() =>
      'EmployeeViewHoursState(enteredStartTime: $enteredStartTime, enteredEndTime: $enteredEndTime)';

  EmployeeViewHoursState copyWith({
    String? enteredStartTime,
    String? enteredEndTime,
  }) {
    return EmployeeViewHoursState(
      enteredStartTime: enteredStartTime ?? this.enteredStartTime,
      enteredEndTime: enteredEndTime ?? this.enteredEndTime,
    );
  }
}
