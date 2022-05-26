import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(AttendanceState.initial()) {
    on<GetEmployeeDetailsEvent>(_getEmployeeDetails);
    on<ClearDetailsEvent>(_clearDetails);
  }

  void _getEmployeeDetails(
    GetEmployeeDetailsEvent event,
    Emitter<AttendanceState> emit,
  ) {
    emit(state.copyWith(
      uniqueId: event.uniqueId,
      firstName: event.firstName,
      lastName: event.lastName,
      employeeId: event.employeeId,
    ));
  }

  void _clearDetails(
    ClearDetailsEvent event,
    Emitter<AttendanceState> emit,
  ) {
    emit(state.copyWith(
      uniqueId: '',
      firstName: '',
      lastName: '',
      employeeId: '',
      clockin: 0,
      clockout: 0,
      workDate: 0,
      status: 0,
    ));
  }
}
