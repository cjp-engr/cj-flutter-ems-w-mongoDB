part of 'payroll_bloc.dart';

enum PayrollStatus {
  loading,
  loaded,
  initial,
  error,
}

class PayrollState extends Equatable {
  final DateTime dateFrom;
  final DateTime dateTo;
  final Payroll payrollDetails;
  final List<Payroll> listPayroll;
  final PayrollStatus payrollStatus;
  const PayrollState({
    required this.dateFrom,
    required this.dateTo,
    required this.payrollDetails,
    required this.listPayroll,
    required this.payrollStatus,
  });

  factory PayrollState.initial() {
    return PayrollState(
      dateFrom: DateTime(1970, 1, 1),
      dateTo: DateTime(1970, 1, 1),
      payrollDetails: const Payroll(),
      listPayroll: const [],
      payrollStatus: PayrollStatus.initial,
    );
  }
  @override
  List<Object?> get props => [
        dateFrom,
        dateTo,
        payrollDetails,
        listPayroll,
        payrollStatus,
      ];

  PayrollState copyWith({
    DateTime? dateFrom,
    DateTime? dateTo,
    Payroll? payrollDetails,
    List<Payroll>? listPayroll,
    PayrollStatus? payrollStatus,
  }) {
    return PayrollState(
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      payrollDetails: payrollDetails ?? this.payrollDetails,
      listPayroll: listPayroll ?? this.listPayroll,
      payrollStatus: payrollStatus ?? this.payrollStatus,
    );
  }

  @override
  String toString() {
    return 'PayrollState(dateFrom: $dateFrom, dateTo: $dateTo, payrollDetails: $payrollDetails, listPayroll: $listPayroll, payrollStatus: $payrollStatus)';
  }
}
