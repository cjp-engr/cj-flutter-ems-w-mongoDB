part of 'payroll_bloc.dart';

class PayrollState extends Equatable {
  final DateTime dateFrom;
  final DateTime dateTo;
  final Payroll payrollDetails;
  final List<Payroll> listPayroll;
  const PayrollState({
    required this.dateFrom,
    required this.dateTo,
    required this.payrollDetails,
    required this.listPayroll,
  });

  factory PayrollState.initial() {
    return PayrollState(
      dateFrom: DateTime(1970, 1, 1),
      dateTo: DateTime(1970, 1, 1),
      payrollDetails: const Payroll(),
      listPayroll: const [],
    );
  }
  @override
  List<Object?> get props => [
        dateFrom,
        dateTo,
        payrollDetails,
        listPayroll,
      ];

  PayrollState copyWith({
    DateTime? dateFrom,
    DateTime? dateTo,
    Payroll? payrollDetails,
    List<Payroll>? listPayroll,
  }) {
    return PayrollState(
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      payrollDetails: payrollDetails ?? this.payrollDetails,
      listPayroll: listPayroll ?? this.listPayroll,
    );
  }

  @override
  String toString() {
    return 'PayrollState(dateFrom: $dateFrom, dateTo: $dateTo, payrollDetails: $payrollDetails, listPayroll: $listPayroll)';
  }
}
