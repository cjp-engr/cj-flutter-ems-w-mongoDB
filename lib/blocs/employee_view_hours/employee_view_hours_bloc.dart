import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'employee_view_hours_event.dart';
part 'employee_view_hours_state.dart';

class EmployeeViewHoursBloc
    extends Bloc<EmployeeViewHoursEvent, EmployeeViewHoursState> {
  EmployeeViewHoursBloc() : super(EmployeeViewHoursState.initial()) {
    on<EnterStartTimeEvent>(_enterStartTime);
    on<EnterEndTimeEvent>(_enterEndTime);
  }

  _enterStartTime(
    EnterStartTimeEvent event,
    Emitter<EmployeeViewHoursState> emit,
  ) {
    emit(state.copyWith(enteredStartTime: event.startTimeEntered));
  }

  _enterEndTime(
    EnterEndTimeEvent event,
    Emitter<EmployeeViewHoursState> emit,
  ) {
    emit(state.copyWith(enteredEndTime: event.endTimeEntered));
  }
}
