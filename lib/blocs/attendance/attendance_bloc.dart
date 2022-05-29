import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ems_app/models/model_custom_error.dart';
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
    on<GetSelectedDateEvent>(_getSelectedDate);
    on<GetWorkedStartTimeEvent>(_getWorkedStartTime);
    on<GetWorkedEndTimeEvent>(_getWorkedEndTime);
    on<AddWorkedTimeEvent>(_addWorkedTime);
    on<SubmitWorkedTimeEvent>(_submitWorkedTime);
    on<ClearDetailsEvent>(_clearDetails);
    on<ClearAddTimeFieldsEvent>(_clearAddTimeFields);
    on<UpdateWorkedStartTimeEvent>(_updateWorkedStartTime);
    on<UpdateWorkedEndTimeEvent>(_updateWorkedEndTime);
    on<DeleteWorkedTimeEvent>(_deleteWorkedTime);
  }

  void _getEmployeeDetails(
    GetEmployeeDetailsEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(
      uniqueId: event.uniqueId,
      firstName: event.firstName,
      lastName: event.lastName,
      employeeId: event.employeeId,
      attStatus: AttendanceStatus.reading,
    ));
    if (state.attStatus == AttendanceStatus.reading) {
      final List<Attendance>? attendance =
          await attendanceRepository.fetchAttendanceList(
        state.uniqueId,
        state.workDate.millisecondsSinceEpoch.toString(),
      );

      emit(state.copyWith(
        attendanceList: attendance,
        attStatus: AttendanceStatus.read,
      ));
      log(state.attStatus.toString());
    }
  }

  void _getSelectedDate(
    GetSelectedDateEvent event,
    Emitter<AttendanceState> emit,
  ) {
    emit(state.copyWith(workDate: event.selectedDate));
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
  ) async {
    emit(state.copyWith(
      attStatus: AttendanceStatus.adding,
    ));

    final attendance = Attendance(
      uniqueId: state.uniqueId,
      firstName: state.firstName,
      lastName: state.lastName,
      employeeId: state.employeeId,
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
    final List<Attendance>? attendance =
        await attendanceRepository.fetchAttendanceList(
      state.uniqueId,
      state.workDate.millisecondsSinceEpoch.toString(),
    );
    emit(state.copyWith(
      attendanceList: attendance,
      attStatus: AttendanceStatus.added,
    ));
    add(ClearAddTimeFieldsEvent());
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
      status: 0,
      attendanceList: [],
    ));
  }

  void _clearAddTimeFields(
    ClearAddTimeFieldsEvent event,
    Emitter<AttendanceState> emit,
  ) {
    emit(state.copyWith(
      clockin: DateTime(1970, 1, 1),
      clockout: DateTime(1970, 1, 1),
    ));
  }

  void _updateWorkedStartTime(
    UpdateWorkedStartTimeEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(attStatus: AttendanceStatus.updating));
    var attendance = Attendance(
      clockin: event.startTime.millisecondsSinceEpoch,
      clockout: event.att.clockout,
    );
    await attendanceRepository.updateAttendance(
      attendance,
      event.att.id!,
    );
    final List<Attendance>? attendanceL =
        await attendanceRepository.fetchAttendanceList(
      state.uniqueId,
      state.workDate.millisecondsSinceEpoch.toString(),
    );
    emit(state.copyWith(
      attendanceList: attendanceL,
      attStatus: AttendanceStatus.updated,
    ));
  }

  void _updateWorkedEndTime(
    UpdateWorkedEndTimeEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(attStatus: AttendanceStatus.updating));
    var attendance = Attendance(
      clockin: event.att.clockin,
      clockout: event.endTime.millisecondsSinceEpoch,
    );
    await attendanceRepository.updateAttendance(
      attendance,
      event.att.id!,
    );
    final List<Attendance>? attendanceL =
        await attendanceRepository.fetchAttendanceList(
      state.uniqueId,
      state.workDate.millisecondsSinceEpoch.toString(),
    );
    emit(state.copyWith(
      attendanceList: attendanceL,
      attStatus: AttendanceStatus.updated,
    ));
  }

  void _deleteWorkedTime(
    DeleteWorkedTimeEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(attStatus: AttendanceStatus.deleting));
    await attendanceRepository.deleteAttendance(event.id);
    final List<Attendance>? attendanceL =
        await attendanceRepository.fetchAttendanceList(
      state.uniqueId,
      state.workDate.millisecondsSinceEpoch.toString(),
    );
    emit(state.copyWith(
      attendanceList: attendanceL,
      attStatus: AttendanceStatus.deleted,
    ));
  }
}
