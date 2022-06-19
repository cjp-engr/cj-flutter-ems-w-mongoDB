import 'package:bloc/bloc.dart';
import 'package:ems_app/models/attendance.dart';
import 'package:ems_app/models/employee.dart';
import 'package:ems_app/repositories/attendance_repository.dart';
import 'package:ems_app/repositories/employee_repository.dart';
import 'package:equatable/equatable.dart';

part 'attendance_today_event.dart';
part 'attendance_today_state.dart';

class AttendanceTodayBloc
    extends Bloc<AttendanceTodayEvent, AttendanceTodayState> {
  final EmployeeRepository employeeRepository;
  final AttendanceRepository attendanceRepository;
  AttendanceTodayBloc({
    required this.employeeRepository,
    required this.attendanceRepository,
  }) : super(AttendanceTodayState.initial()) {
    on<EnterAttendancePinEvent>(_enterAttendancePin);
    on<ClockInClickedEvent>(_clockInClicked);
    on<ClockOutClickedEvent>(_clockOutClicked);
    on<EnterAttClickedEvent>(_enterAttClicked);
    on<ClockInSuccessfulEvent>(_clockInSuccessful);
    on<ClockOutSuccessfulEvent>(_clockOutSuccessful);
    on<SubmitWorkedTimeTodayEvent>(_submitWorkedTimeToday);
    on<ClearDetailsTodayEvent>(_clearDetailsToday);
    on<IsEmployeeEnteredEvent>(_isEmployeeEntered);
  }

  void _enterAttendancePin(
    EnterAttendancePinEvent event,
    Emitter<AttendanceTodayState> emit,
  ) {
    if (event.enteredPIN == 'C' && state.pin.isNotEmpty) {
      state.pin.removeLast();
      emit(state.copyWith(
        pin: state.pin,
        pinLength: state.pin.length,
      ));
    } else if (event.enteredPIN != 'C') {
      if (state.pinLength < 4) {
        List<String> a = [];
        if (event.enteredPIN == '00') {
          if (state.pinLength < 3) {
            int i = 0;
            while (i < 2) {
              a = [...state.pin, '0'];
              i += 1;
              emit(state.copyWith(
                pin: a,
                pinLength: state.pin.length + 1,
              ));
            }
          } else {
            a = [...state.pin, '0'];
            emit(state.copyWith(
              pin: a,
              pinLength: state.pin.length + 1,
            ));
          }
        } else {
          a = [...state.pin, event.enteredPIN];
          emit(state.copyWith(
            pin: a,
            pinLength: state.pin.length + 1,
          ));
        }
      }
    }
  }

  void _clockInClicked(
    ClockInClickedEvent event,
    Emitter<AttendanceTodayState> emit,
  ) async {
    emit(state.copyWith(
      attTodayStatus: AttendanceTodayPinStatus.loading,
    ));
    String strPin = state.pin.join('');
    int? inPin = int.tryParse(strPin);
    Employee? emp = await employeeRepository.fetchEmployeePin(strPin);

    if (emp.toString() != 'null') {
      if (inPin == emp?.pin) {
        emit(state.copyWith(
          pin: [],
          attTodayStatus: AttendanceTodayPinStatus.isExisting,
          pinLength: 0,
        ));
        add(ClockInSuccessfulEvent(employee: emp!));
      } else {
        emit(state.copyWith(
          pin: [],
          attTodayStatus: AttendanceTodayPinStatus.isNotExisting,
          pinLength: 0,
        ));
      }
    } else {
      emit(state.copyWith(
        pin: [],
        attTodayStatus: AttendanceTodayPinStatus.isNotExisting,
        pinLength: 0,
      ));
    }
  }

  void _clockInSuccessful(
    ClockInSuccessfulEvent event,
    Emitter<AttendanceTodayState> emit,
  ) {
    emit(state.copyWith(
      attTodayStatus: AttendanceTodayPinStatus.adding,
    ));
    final attendance = Attendance(
      uniqueId: event.employee.id,
      firstName: event.employee.firstName,
      lastName: event.employee.lastName,
      employeeId: event.employee.employeeId,
      hourlyRate: event.employee.hourlyRate,
      clockin: DateTime.now().millisecondsSinceEpoch,
      clockout: -1,
      workDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ).millisecondsSinceEpoch,
      status: 1,
    );

    add(SubmitWorkedTimeTodayEvent(attendance: attendance));
    emit(state.copyWith(
      attTodayStatus: AttendanceTodayPinStatus.added,
    ));
  }

  void _clockOutClicked(
    ClockOutClickedEvent event,
    Emitter<AttendanceTodayState> emit,
  ) async {
    emit(state.copyWith(
      attTodayStatus: AttendanceTodayPinStatus.loading,
    ));
    String strPin = state.pin.join('');
    int? inPin = int.tryParse(strPin);
    Employee? emp = await employeeRepository.fetchEmployeePin(strPin);

    if (emp.toString() != 'null') {
      if (inPin == emp?.pin) {
        emit(state.copyWith(
          pin: [],
          attTodayStatus: AttendanceTodayPinStatus.isExisting,
          pinLength: 0,
        ));
        add(ClockOutSuccessfulEvent(employee: emp!));
      } else {
        emit(state.copyWith(
          pin: [],
          attTodayStatus: AttendanceTodayPinStatus.isNotExisting,
          pinLength: 0,
        ));
      }
    } else {
      emit(state.copyWith(
        pin: [],
        attTodayStatus: AttendanceTodayPinStatus.isNotExisting,
        pinLength: 0,
      ));
    }
  }

  void _clockOutSuccessful(
    ClockOutSuccessfulEvent event,
    Emitter<AttendanceTodayState> emit,
  ) async {
    emit(state.copyWith(
      attTodayStatus: AttendanceTodayPinStatus.updating,
    ));

    String workDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).millisecondsSinceEpoch.toString();

    List<Attendance>? x = await attendanceRepository.fetchAttendanceList(
        event.employee.id!, workDate);
    int clockIn = 0;
    for (var element in x!) {
      if (element.clockout == -1) {
        clockIn = element.clockin!;
      }
    }
    final attendance = Attendance(
      clockout: DateTime.now().millisecondsSinceEpoch,
      clockin: clockIn,
      status: 2,
    );

    await attendanceRepository.updateTodayAttendance(
      event.employee.id!,
      workDate,
      attendance,
    );

    emit(state.copyWith(
      attTodayStatus: AttendanceTodayPinStatus.updated,
    ));
  }

  void _enterAttClicked(
    EnterAttClickedEvent event,
    Emitter<AttendanceTodayState> emit,
  ) async {
    String strPin = state.pin.join('');
    int? inPin = int.tryParse(strPin);
    Employee? emp = await employeeRepository.fetchEmployeePin(strPin);

    if (emp.toString() != 'null' &&
        (state.enterStatus == EnterTodayPinStatus.isNotEntered ||
            state.enterStatus == EnterTodayPinStatus.initial)) {
      if (inPin == emp?.pin) {
        if (emp?.jobRole == 'Manager') {
          emit(state.copyWith(
            pin: [],
            enterStatus: EnterTodayPinStatus.isManager,
            pinLength: 0,
          ));
        } else {
          emit(state.copyWith(
            pin: [],
            enterStatus: EnterTodayPinStatus.isNotManager,
            pinLength: 0,
          ));
        }
      }
    } else {
      emit(state.copyWith(
        pin: [],
        enterStatus: EnterTodayPinStatus.isNotExisting,
        pinLength: 0,
      ));
    }
  }

  void _submitWorkedTimeToday(
    SubmitWorkedTimeTodayEvent event,
    Emitter<AttendanceTodayState> emit,
  ) async {
    await attendanceRepository.addAttendance(event.attendance);
  }

  void _clearDetailsToday(
    ClearDetailsTodayEvent event,
    Emitter<AttendanceTodayState> emit,
  ) {}

  void _isEmployeeEntered(
    IsEmployeeEnteredEvent event,
    Emitter<AttendanceTodayState> emit,
  ) {
    if (event.isEntered) {
      emit(state.copyWith(enterStatus: EnterTodayPinStatus.isEntered));
    } else {
      emit(state.copyWith(enterStatus: EnterTodayPinStatus.isNotEntered));
    }
  }
}
