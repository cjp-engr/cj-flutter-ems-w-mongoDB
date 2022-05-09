part of 'country_codes_bloc.dart';

enum CountryCodeStatus {
  initial,
  loading,
  loaded,
  error,
}

class CountryCodesState extends Equatable {
  final List<CountryCodes> countryCodesList;
  final CountryCodeStatus countryCodeStatus;
  final CustomError customError;
  const CountryCodesState({
    required this.countryCodesList,
    required this.countryCodeStatus,
    required this.customError,
  });

  factory CountryCodesState.initial() {
    return const CountryCodesState(
      countryCodesList: [],
      countryCodeStatus: CountryCodeStatus.initial,
      customError: CustomError(),
    );
  }
  @override
  List<Object?> get props => [
        countryCodesList,
        countryCodeStatus,
        customError,
      ];

  @override
  String toString() =>
      'CountryCodesState(countryCodesList: $countryCodesList, countryCodeStatus: $countryCodeStatus, customError: $customError,)';

  CountryCodesState copyWith({
    List<CountryCodes>? countryCodesList,
    CountryCodeStatus? countryCodeStatus,
    CustomError? customError,
  }) {
    return CountryCodesState(
      countryCodesList: countryCodesList ?? this.countryCodesList,
      countryCodeStatus: countryCodeStatus ?? this.countryCodeStatus,
      customError: customError ?? this.customError,
    );
  }
}
