import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ems_app/models/model_custom_error.dart';
import 'package:ems_app/models/country_codes.dart';
import 'package:ems_app/repositories/country_code_repository.dart';
import 'package:equatable/equatable.dart';

part 'country_codes_event.dart';
part 'country_codes_state.dart';

class CountryCodesBloc extends Bloc<CountryCodesEvent, CountryCodesState> {
  final CountryCodeRepository countryCodeRepository;
  CountryCodesBloc({
    required this.countryCodeRepository,
  }) : super(CountryCodesState.initial()) {
    on<FetchAllCountryCodesEvent>(_fetchAllCountryCodes);
    on<FilterCountriesEvent>(_filterCountries);
    on<SelectCountryCodeEvent>(_selectCountryCode);
  }

  FutureOr<void> _fetchAllCountryCodes(
    FetchAllCountryCodesEvent event,
    Emitter<CountryCodesState> emit,
  ) async {
    emit(state.copyWith(countryCodeStatus: CountryCodeStatus.loading));
    try {
      final List<CountryCodes>? ccList =
          await countryCodeRepository.fetchCountryCodesList();
      emit(state.copyWith(
        countryCodesList: ccList,
        countryCodeStatus: CountryCodeStatus.loaded,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        countryCodeStatus: CountryCodeStatus.error,
        customError: e,
      ));
    }
  }

  FutureOr<void> _filterCountries(
    FilterCountriesEvent event,
    Emitter<CountryCodesState> emit,
  ) async {
    emit(state.copyWith(countryCodeStatus: CountryCodeStatus.loading));
    try {
      List<CountryCodes> _filteredCCList = [];
      if (event.enteredKeyword.contains(RegExp(r'[0-9]')) ||
          event.enteredKeyword.contains(RegExp(r'[+]'))) {
        _filteredCCList = state.countryCodesList
            .where((CountryCodes countryCodes) =>
                countryCodes.code!.toLowerCase().contains(event.enteredKeyword))
            .toList();
      } else {
        _filteredCCList = state.countryCodesList
            .where((CountryCodes countryCodes) =>
                countryCodes.name!.toLowerCase().contains(event.enteredKeyword))
            .toList();
      }

      emit(state.copyWith(
        countryCodesList: _filteredCCList,
        countryCodeStatus: CountryCodeStatus.loaded,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        countryCodeStatus: CountryCodeStatus.error,
        customError: e,
      ));
    }
  }

  FutureOr<void> _selectCountryCode(
    SelectCountryCodeEvent event,
    Emitter<CountryCodesState> emit,
  ) {
    emit(state.copyWith(selectedCountryCode: event.selectedCountryCode));
  }
}
