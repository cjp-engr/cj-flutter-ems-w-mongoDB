part of 'employee_pin_bloc.dart';

enum EmployeePinStatus {
  initial,
  isExisting,
  isNotExisting,
  enteredAndReEnteredNotMatch,
  enteredAndReEnteredMatch,
}

class EmployeePinState extends Equatable {
  final List<String> pin;
  final EmployeePinStatus empPinStatus;
  final int pinLength;
  final int enteredPIN;
  final int reEnteredPIN;
  const EmployeePinState({
    required this.pin,
    required this.empPinStatus,
    required this.pinLength,
    required this.enteredPIN,
    required this.reEnteredPIN,
  });

  factory EmployeePinState.initial() {
    return const EmployeePinState(
      pin: [],
      empPinStatus: EmployeePinStatus.initial,
      pinLength: 0,
      enteredPIN: 0,
      reEnteredPIN: 0,
    );
  }

  @override
  List<Object?> get props => [
        pin,
        empPinStatus,
        pinLength,
        enteredPIN,
        reEnteredPIN,
      ];

  @override
  String toString() {
    return 'EmployeePinState(pin: $pin, empPinStatus: $empPinStatus, pinLength: $pinLength, enteredPIN: $enteredPIN, reEnteredPIN: $reEnteredPIN)';
  }

  EmployeePinState copyWith({
    List<String>? pin,
    EmployeePinStatus? empPinStatus,
    int? pinLength,
    int? enteredPIN,
    int? reEnteredPIN,
  }) {
    return EmployeePinState(
      pin: pin ?? this.pin,
      empPinStatus: empPinStatus ?? this.empPinStatus,
      pinLength: pinLength ?? this.pinLength,
      enteredPIN: enteredPIN ?? this.enteredPIN,
      reEnteredPIN: reEnteredPIN ?? this.reEnteredPIN,
    );
  }
}
