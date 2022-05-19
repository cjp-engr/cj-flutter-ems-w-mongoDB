import 'package:bloc/bloc.dart';
import 'package:ems_app/models/employee.dart';

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
    on<SetInitialPinEvent>(_setInitialPin);
  }

  void _setInitialPin(
    SetInitialPinEvent event,
    Emitter<EmployeePinState> emit,
  ) {
    emit(state.copyWith(
      pin: [],
      empPinStatus: EmployeePinStatus.initial,
      pinLength: 0,
      enteredPIN: 0,
      reEnteredPIN: 0,
    ));
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
  ) async {
    String strPin = state.pin.join('');
    int? inPin = int.tryParse(strPin);
    Employee? emp = await employeeRepository.fetchEmployeePin(strPin);
    //log(employee.firstName!);
    if (inPin == emp?.pin) {
      emit(state.copyWith(
        pin: [],
        empPinStatus: EmployeePinStatus.isExisting,
        pinLength: 0,
      ));
    } else {
      if (state.enteredPIN == 0) {
        emit(state.copyWith(
          enteredPIN: inPin,
          pin: [],
          empPinStatus: EmployeePinStatus.isNotExisting,
          pinLength: 0,
        ));
      } else {
        if (state.enteredPIN == inPin) {
          emit(state.copyWith(
            reEnteredPIN: inPin,
            pin: [],
            empPinStatus: EmployeePinStatus.enteredAndReEnteredMatch,
            pinLength: 0,
          ));
        } else {
          emit(state.copyWith(
            pin: [],
            empPinStatus: EmployeePinStatus.enteredAndReEnteredNotMatch,
            pinLength: 0,
            enteredPIN: 0,
            reEnteredPIN: 0,
          ));
        }
      }
    }
  }
}
