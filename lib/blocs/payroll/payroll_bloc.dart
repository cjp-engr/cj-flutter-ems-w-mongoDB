import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payroll_event.dart';
part 'payroll_state.dart';

class PayrollBloc extends Bloc<PayrollEvent, PayrollState> {
  PayrollBloc() : super(PayrollState.initial()) {
    on<GetDateFromEvent>(_getDateFrom);
    on<GetDateToEvent>(_getDateTo);
  }

  void _getDateFrom(
    GetDateFromEvent event,
    Emitter<PayrollState> emit,
  ) {
    emit(state.copyWith(dateFrom: event.selectedDate));
  }

  void _getDateTo(
    GetDateToEvent event,
    Emitter<PayrollState> emit,
  ) {
    emit(state.copyWith(dateTo: event.selectedDate));
  }
}
