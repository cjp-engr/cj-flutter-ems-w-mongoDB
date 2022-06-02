part of 'attendance_today_bloc.dart';

enum AttendanceTodayPinStatus {
  loading,
  initial,
  isExisting,
  isNotExisting,
}

class AttendanceTodayState extends Equatable {
  final List<String> pin;
  final int pinLength;
  final int enteredPIN;
  final AttendanceTodayPinStatus attTodayStatus;

  const AttendanceTodayState({
    required this.pin,
    required this.pinLength,
    required this.enteredPIN,
    required this.attTodayStatus,
  });

  factory AttendanceTodayState.initial() {
    return const AttendanceTodayState(
      pin: [],
      pinLength: 0,
      enteredPIN: 0,
      attTodayStatus: AttendanceTodayPinStatus.initial,
    );
  }

  @override
  List<Object?> get props => [
        pin,
        pinLength,
        enteredPIN,
        attTodayStatus,
      ];

  AttendanceTodayState copyWith({
    List<String>? pin,
    int? pinLength,
    int? enteredPIN,
    AttendanceTodayPinStatus? attTodayStatus,
  }) {
    return AttendanceTodayState(
      pin: pin ?? this.pin,
      pinLength: pinLength ?? this.pinLength,
      enteredPIN: enteredPIN ?? this.enteredPIN,
      attTodayStatus: attTodayStatus ?? this.attTodayStatus,
    );
  }

  @override
  String toString() {
    return 'AttendanceTodayState(pin: $pin, pinLength: $pinLength, enteredPIN: $enteredPIN, attTodayStatus: $attTodayStatus)';
  }
}
