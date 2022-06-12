import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payroll_event.dart';
part 'payroll_state.dart';

class PayrollBloc extends Bloc<PayrollEvent, PayrollState> {
  PayrollBloc() : super(PayrollInitial()) {
    on<PayrollEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
