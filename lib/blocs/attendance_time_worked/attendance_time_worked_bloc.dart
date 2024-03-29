import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

part 'attendance_time_worked_event.dart';
part 'attendance_time_worked_state.dart';

class AttendanceTimeWorkedBloc
    extends Bloc<AttendanceTimeWorkedEvent, AttendanceTimeWorkedState> {
  AttendanceTimeWorkedBloc() : super(AttendanceTimeWorkedState.initial()) {
    on<GetTimeWorkedEvent>(_getTimeWorked);
  }

  void _getTimeWorked(
    GetTimeWorkedEvent event,
    Emitter<AttendanceTimeWorkedState> emit,
  ) {
    final hours = event.duration.inHours;
    final minutes = (((event.duration.inMinutes / 60) - hours) * 60).round();
    emit(state.copyWith(
      hours: hours.toString(),
      minutes: minutes.toString(),
    ));
  }
}
