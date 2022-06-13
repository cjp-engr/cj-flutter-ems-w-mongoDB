part of 'payroll_bloc.dart';

class PayrollState extends Equatable {
  final DateTime dateFrom;
  final DateTime dateTo;
  final Payroll payrollDetails;
  const PayrollState({
    required this.dateFrom,
    required this.dateTo,
    required this.payrollDetails,
  });

  factory PayrollState.initial() {
    return PayrollState(
      dateFrom: DateTime(1970, 1, 1),
      dateTo: DateTime(1970, 1, 1),
      payrollDetails: const Payroll(),
    );
  }
  @override
  List<Object?> get props => [
        dateFrom,
        dateTo,
        payrollDetails,
      ];

  PayrollState copyWith({
    DateTime? dateFrom,
    DateTime? dateTo,
    Payroll? payrollDetails,
  }) {
    return PayrollState(
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      payrollDetails: payrollDetails ?? this.payrollDetails,
    );
  }

  @override
  String toString() =>
      'PayrollState(dateFrom: $dateFrom, dateTo: $dateTo, payrollDetails: $payrollDetails)';
}
