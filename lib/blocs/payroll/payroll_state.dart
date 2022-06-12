part of 'payroll_bloc.dart';

class PayrollState extends Equatable {
  final DateTime dateFrom;
  final DateTime dateTo;
  const PayrollState({
    required this.dateFrom,
    required this.dateTo,
  });

  factory PayrollState.initial() {
    return PayrollState(
      dateFrom: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      dateTo: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
    );
  }
  @override
  List<Object?> get props => [
        dateFrom,
        dateTo,
      ];

  PayrollState copyWith({
    DateTime? dateFrom,
    DateTime? dateTo,
  }) {
    return PayrollState(
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
    );
  }

  @override
  String toString() => 'PayrollState(dateFrom: $dateFrom, dateTo: $dateTo)';
}
