import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ems_app/models/country_code_custom_error.dart';
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
}
