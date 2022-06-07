part of 'attendance_today_bloc.dart';

enum AttendanceTodayPinStatus {
  loading,
  initial,
  isExisting,
  isNotExisting,
  adding,
  added,
  clear,
  reading,
  read,
  updating,
  updated,
  deleting,
  deleted,
  error,
}

enum EnterTodayPinStatus {
  loading,
  initial,
  isManager,
  isNotManager,
  isNotExisting,
  loaded,
  error,
}

class AttendanceTodayState extends Equatable {
  final List<String> pin;
  final int pinLength;
  final int enteredPIN;
  final AttendanceTodayPinStatus attTodayStatus;
  final EnterTodayPinStatus enterStatus;
  final Employee employee;

  const AttendanceTodayState({
    required this.pin,
    required this.pinLength,
    required this.enteredPIN,
    required this.attTodayStatus,
    required this.enterStatus,
    required this.employee,
  });

  factory AttendanceTodayState.initial() {
    return const AttendanceTodayState(
      pin: [],
      pinLength: 0,
      enteredPIN: 0,
      attTodayStatus: AttendanceTodayPinStatus.initial,
      enterStatus: EnterTodayPinStatus.initial,
      employee: Employee(
        firstName: '',
        lastName: '',
        email: '',
        countryCode: '',
        phoneNumber: '',
        employeeId: '',
        jobRole: '',
        payType: '',
        hourlyRate: 0,
        weeklyHours: 0,
        pin: 0,
      ),
    );
  }

  @override
  List<Object?> get props => [
        pin,
        pinLength,
        enteredPIN,
        attTodayStatus,
        enterStatus,
        employee,
      ];

  AttendanceTodayState copyWith({
    List<String>? pin,
    int? pinLength,
    int? enteredPIN,
    AttendanceTodayPinStatus? attTodayStatus,
    EnterTodayPinStatus? enterStatus,
    Employee? employee,
  }) {
    return AttendanceTodayState(
      pin: pin ?? this.pin,
      pinLength: pinLength ?? this.pinLength,
      enteredPIN: enteredPIN ?? this.enteredPIN,
      attTodayStatus: attTodayStatus ?? this.attTodayStatus,
      enterStatus: enterStatus ?? this.enterStatus,
      employee: employee ?? this.employee,
    );
  }

  @override
  String toString() {
    return 'AttendanceTodayState(pin: $pin, pinLength: $pinLength, enteredPIN: $enteredPIN, attTodayStatus: $attTodayStatus, enterStatus: $enterStatus, employee: $employee)';
  }
}
