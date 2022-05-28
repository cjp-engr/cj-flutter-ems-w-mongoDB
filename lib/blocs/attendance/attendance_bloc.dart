import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ems_app/models/attendance.dart';
import 'package:ems_app/repositories/attendance_repository.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository attendanceRepository;
  AttendanceBloc({
    required this.attendanceRepository,
  }) : super(AttendanceState.initial()) {
    on<GetEmployeeDetailsEvent>(_getEmployeeDetails);
    on<ClearDetailsEvent>(_clearDetails);
    on<GetSelectedDateEvent>(_getSelectedDate);
    on<GetWorkedStartTimeEvent>(_getWorkedStartTime);
    on<GetWorkedEndTimeEvent>(_getWorkedEndTime);
    on<AddWorkedTimeEvent>(_addWorkedTime);
    on<SubmitWorkedTimeEvent>(_submitWorkedTime);
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

  void _getSelectedDate(
    GetSelectedDateEvent event,
    Emitter<AttendanceState> emit,
  ) {
    emit(state.copyWith(workDate: event.selectedDate));
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
      clockin: DateTime.now(),
      clockout: DateTime.now(),
      workDate: DateTime.now(),
      status: 0,
    ));
  }

  void _getWorkedStartTime(
    GetWorkedStartTimeEvent event,
    Emitter<AttendanceState> emit,
  ) {
    emit(state.copyWith(clockin: event.startTime));
  }

  void _getWorkedEndTime(
    GetWorkedEndTimeEvent event,
    Emitter<AttendanceState> emit,
  ) {
    emit(state.copyWith(clockout: event.endTime));
  }

  void _addWorkedTime(
    AddWorkedTimeEvent event,
    Emitter<AttendanceState> emit,
  ) {
    final attendance = Attendance(
      uniqueId: state.uniqueId,
      firstName: state.firstName,
      lastName: state.lastName,
      employeeId: state.lastName,
      clockin: state.clockin.millisecondsSinceEpoch,
      clockout: state.clockout.millisecondsSinceEpoch,
      workDate: state.workDate.millisecondsSinceEpoch,
      status: 3,
    );

    add(SubmitWorkedTimeEvent(attendance: attendance));
  }

  void _submitWorkedTime(
    SubmitWorkedTimeEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    await attendanceRepository.addAttendance(event.attendance);
  }
}
