import 'package:bloc/bloc.dart';
import 'package:ems_app/models/payroll.dart';
import 'package:ems_app/repositories/payroll_repository.dart';
import 'package:equatable/equatable.dart';

part 'payroll_event.dart';
part 'payroll_state.dart';

class PayrollBloc extends Bloc<PayrollEvent, PayrollState> {
  final PayrollRepository payrollRepository;
  PayrollBloc({
    required this.payrollRepository,
  }) : super(PayrollState.initial()) {
    on<SetInitialDatesEvent>(_setInitialDates);
    on<GetDateFromEvent>(_getDateFrom);
    on<GetDateToEvent>(_getDateTo);
    on<GetEmployeeUniqueIdPR>(_getEmployeeUniqueIdPR);
  }

  void _getEmployeeUniqueIdPR(
    GetEmployeeUniqueIdPR event,
    Emitter<PayrollState> emit,
  ) async {
    emit(state.copyWith(payrollStatus: PayrollStatus.loading));
    final List<Payroll>? pr = await payrollRepository.fetchPayrollList(
        event.uniqueId,
        state.dateTo.millisecondsSinceEpoch.toString(),
        state.dateFrom.millisecondsSinceEpoch.toString());
    // int x = 0;
    // for (var element in pr!) {
    //   x += element.clockout! - element.clockin!;
    // }
    // log((x / 360000).toString());
    emit(state.copyWith(listPayroll: pr, payrollStatus: PayrollStatus.loaded));
  }

  void _setInitialDates(
    SetInitialDatesEvent event,
    Emitter<PayrollState> emit,
  ) {
    add(
      GetDateFromEvent(
        selectedDate: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ),
      ),
    );
    add(
      GetDateToEvent(
        selectedDate: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ),
      ),
    );
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
