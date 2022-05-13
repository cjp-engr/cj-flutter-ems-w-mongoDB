import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'employee_pin_event.dart';
part 'employee_pin_state.dart';

class EmployeePinBloc extends Bloc<EmployeePinEvent, EmployeePinState> {
  EmployeePinBloc() : super(EmployeePinState.initial()) {
    on<EmployeePinEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
