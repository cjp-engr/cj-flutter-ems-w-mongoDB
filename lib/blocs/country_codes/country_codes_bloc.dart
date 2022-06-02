import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../blocs/blocs.dart';
import '../../models/model_custom_error.dart';
import '../../models/country_codes.dart';
import '../../repositories/country_code_repository.dart';
import 'package:equatable/equatable.dart';

part 'country_codes_event.dart';
part 'country_codes_state.dart';

class CountryCodesBloc extends Bloc<CountryCodesEvent, CountryCodesState> {
  late final StreamSubscription employeeDetailsSubscription;
  final CountryCodeRepository countryCodeRepository;
  final EmployeeDetailsBloc employeeDetailsBloc;
  CountryCodesBloc({
    required this.countryCodeRepository,
    required this.employeeDetailsBloc,
  }) : super(CountryCodesState.initial()) {
    employeeDetailsSubscription = employeeDetailsBloc.stream
        .listen((EmployeeDetailsState empDetailsState) {
      isAddingEmployee();
    });
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

  void isAddingEmployee() {
    if (employeeDetailsBloc.state.employeeStatus == EmployeeStatus.read) {
      add(SelectCountryCodeEvent(
          selectedCountryCode:
              employeeDetailsBloc.state.employeeDetails.countryCode!));
    } else if (employeeDetailsBloc.state.employeeStatus ==
        EmployeeStatus.adding) {
      add(const SelectCountryCodeEvent(selectedCountryCode: '+63'));
    }
  }

  @override
  Future<void> close() {
    employeeDetailsSubscription.cancel();
    return super.close();
  }
}
