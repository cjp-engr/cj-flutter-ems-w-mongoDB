part of 'payroll_bloc.dart';

abstract class PayrollState extends Equatable {
  const PayrollState();
  
  @override
  List<Object> get props => [];
}

class PayrollInitial extends PayrollState {}
