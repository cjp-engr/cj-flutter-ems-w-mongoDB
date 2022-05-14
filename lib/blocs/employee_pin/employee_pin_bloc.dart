import 'package:bloc/bloc.dart';
import 'package:ems_app/repositories/employee_repository.dart';
import 'package:equatable/equatable.dart';

part 'employee_pin_event.dart';
part 'employee_pin_state.dart';

class EmployeePinBloc extends Bloc<EmployeePinEvent, EmployeePinState> {
  final EmployeeRepository employeeRepository;
  EmployeePinBloc({
    required this.employeeRepository,
  }) : super(EmployeePinState.initial()) {
    on<EnterEmployeePinEvent>(_enterEmployeePin);
    on<EnterClickedEvent>(_enterClicked);
  }
  void _enterEmployeePin(
    EnterEmployeePinEvent event,
    Emitter<EmployeePinState> emit,
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

  void _enterClicked(
    EnterClickedEvent event,
    Emitter<EmployeePinState> emit,
  ) {
    if (true) {}
  }
}
