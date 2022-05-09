import 'package:ems_app/exceptions/custom_exception.dart';
import 'package:ems_app/models/model_custom_error.dart';
import 'package:ems_app/models/country_codes.dart';
import 'package:ems_app/services/country_code_api_services.dart';

class CountryCodeRepository {
  final CountryCodeApiServices countryCodeApiServices;
  CountryCodeRepository({
    required this.countryCodeApiServices,
  });

  Future<List<CountryCodes>?> fetchCountryCodesList() async {
    try {
      List<CountryCodes>? countryCodes =
          await countryCodeApiServices.getCountryCode();
      return countryCodes;
    } on CustomException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }
}
