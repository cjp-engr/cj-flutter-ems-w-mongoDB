part of 'employee_pin_bloc.dart';

class EmployeePinState extends Equatable {
  final String enteredPIN;
  final String reEnteredPIN;
  final bool isClearClicked;
  const EmployeePinState({
    required this.enteredPIN,
    required this.reEnteredPIN,
    required this.isClearClicked,
  });

  factory EmployeePinState.initial() {
    return const EmployeePinState(
      enteredPIN: '',
      reEnteredPIN: '',
      isClearClicked: false,
    );
  }

  @override
  List<Object?> get props => [
        enteredPIN,
        reEnteredPIN,
        isClearClicked,
      ];
}
