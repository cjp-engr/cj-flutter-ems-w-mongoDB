import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ems_app/blocs/attendance/attendance_bloc.dart';
import 'package:equatable/equatable.dart';

part 'attendance_time_worked_event.dart';
part 'attendance_time_worked_state.dart';

class AttendanceTimeWorkedBloc
    extends Bloc<AttendanceTimeWorkedEvent, AttendanceTimeWorkedState> {
  late final StreamSubscription attendanceSubscription;
  final AttendanceBloc attendanceBloc;
  AttendanceTimeWorkedBloc({
    required this.attendanceBloc,
  }) : super(AttendanceTimeWorkedState.initial()) {
    // attendanceSubscription =
    //     attendanceBloc.stream.listen((AttendanceState state) {
    //   if (attendanceBloc.state.attStatus == AttendanceStatus.read ||
    //       attendanceBloc.state.attStatus == AttendanceStatus.added ||
    //       attendanceBloc.state.attStatus == AttendanceStatus.updated ||
    //       attendanceBloc.state.attStatus == AttendanceStatus.deleted) {
    //     int totalWorked = 0;
    //     for (var item in state.attendanceList) {
    //       totalWorked += (item.clockout! - item.clockin!);
    //     }
    //     log(totalWorked.toString());
    //   }
    // });
    on<DisplayTimeWorkedEvent>(_displayTimeWorked);
  }

  void _displayTimeWorked(
    DisplayTimeWorkedEvent event,
    Emitter<AttendanceTimeWorkedState> emit,
  ) {}

  @override
  Future<void> close() {
    attendanceSubscription.cancel();
    return super.close();
  }
}
