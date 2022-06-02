part of 'attendance_today_bloc.dart';

class AttendanceTodayState extends Equatable {
  final List<String> pin;
  final int pinLength;
  final int enteredPIN;

  const AttendanceTodayState({
    required this.pin,
    required this.pinLength,
    required this.enteredPIN,
  });

  factory AttendanceTodayState.initial() {
    return const AttendanceTodayState(
      pin: [],
      pinLength: 0,
      enteredPIN: 0,
    );
  }

  @override
  List<Object?> get props => [
        pin,
        pinLength,
        enteredPIN,
      ];

  AttendanceTodayState copyWith({
    List<String>? pin,
    int? pinLength,
    int? enteredPIN,
  }) {
    return AttendanceTodayState(
      pin: pin ?? this.pin,
      pinLength: pinLength ?? this.pinLength,
      enteredPIN: enteredPIN ?? this.enteredPIN,
    );
  }

  @override
  String toString() =>
      'AttendanceTodayState(pin: $pin, pinLength: $pinLength, enteredPIN: $enteredPIN)';
}
