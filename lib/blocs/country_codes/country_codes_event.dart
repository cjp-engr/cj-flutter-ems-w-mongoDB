part of 'country_codes_bloc.dart';

abstract class CountryCodesEvent extends Equatable {
  const CountryCodesEvent();

  @override
  List<Object> get props => [];
}

class FetchAllCountryCodesEvent extends CountryCodesEvent {}
