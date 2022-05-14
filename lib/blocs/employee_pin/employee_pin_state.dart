part of 'employee_pin_bloc.dart';

class EmployeePinState extends Equatable {
  final List<String> pin;
  final int pinLength;
  final int enteredPIN;
  final int reEnteredPIN;
  const EmployeePinState({
    required this.pin,
    required this.pinLength,
    required this.enteredPIN,
    required this.reEnteredPIN,
  });

  factory EmployeePinState.initial() {
    return const EmployeePinState(
      pin: [],
      pinLength: 0,
      enteredPIN: 0,
      reEnteredPIN: 0,
    );
  }

  @override
  List<Object?> get props => [
        pin,
        pinLength,
        enteredPIN,
        reEnteredPIN,
      ];

  @override
  String toString() {
    return 'EmployeePinState(pin: $pin, pinLength: $pinLength, enteredPIN: $enteredPIN, reEnteredPIN: $reEnteredPIN)';
  }

  EmployeePinState copyWith({
    List<String>? pin,
    int? pinLength,
    int? enteredPIN,
    int? reEnteredPIN,
  }) {
    return EmployeePinState(
      pin: pin ?? this.pin,
      pinLength: pinLength ?? this.pinLength,
      enteredPIN: enteredPIN ?? this.enteredPIN,
      reEnteredPIN: reEnteredPIN ?? this.reEnteredPIN,
    );
  }
}
