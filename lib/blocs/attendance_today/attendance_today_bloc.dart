import 'package:bloc/bloc.dart';
import 'package:ems_app/models/employee.dart';
import 'package:ems_app/repositories/employee_repository.dart';
import 'package:equatable/equatable.dart';

part 'attendance_today_event.dart';
part 'attendance_today_state.dart';

class AttendanceTodayBloc
    extends Bloc<AttendanceTodayEvent, AttendanceTodayState> {
  final EmployeeRepository employeeRepository;
  AttendanceTodayBloc({
    required this.employeeRepository,
  }) : super(AttendanceTodayState.initial()) {
    on<EnterAttendancePinEvent>(_enterAttendancePin);
    on<ClockInClickedEvent>(_clockInClicked);
    on<ClockOutClickedEvent>(_clockOutClicked);
  }

  _enterAttendancePin(
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
}
