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
  final String selectedCountryCode;
  final CustomError customError;
  const CountryCodesState({
    required this.countryCodesList,
    required this.countryCodeStatus,
    required this.selectedCountryCode,
    required this.customError,
  });

  factory CountryCodesState.initial() {
    return const CountryCodesState(
      countryCodesList: [],
      countryCodeStatus: CountryCodeStatus.initial,
      selectedCountryCode: '+63',
      customError: CustomError(),
    );
  }
  @override
  List<Object?> get props => [
        countryCodesList,
        countryCodeStatus,
        selectedCountryCode,
        customError,
      ];

  @override
  String toString() {
    return 'CountryCodesState(countryCodesList: $countryCodesList, countryCodeStatus: $countryCodeStatus, selectedCountryCode: $selectedCountryCode, customError: $customError)';
  }

  CountryCodesState copyWith({
    List<CountryCodes>? countryCodesList,
    CountryCodeStatus? countryCodeStatus,
    String? selectedCountryCode,
    CustomError? customError,
  }) {
    return CountryCodesState(
      countryCodesList: countryCodesList ?? this.countryCodesList,
      countryCodeStatus: countryCodeStatus ?? this.countryCodeStatus,
      selectedCountryCode: selectedCountryCode ?? this.selectedCountryCode,
      customError: customError ?? this.customError,
    );
  }
}
