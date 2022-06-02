import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'attendance_today_event.dart';
part 'attendance_today_state.dart';

class AttendanceTodayBloc
    extends Bloc<AttendanceTodayEvent, AttendanceTodayState> {
  AttendanceTodayBloc() : super(AttendanceTodayState.initial()) {
    on<EnterAttendancePinEvent>(_enterAttendancePin);
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
}
