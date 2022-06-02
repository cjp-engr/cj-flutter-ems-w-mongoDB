import '../../exceptions/custom_exception.dart';
import '../../models/model_custom_error.dart';
import '../../models/country_codes.dart';
import '../../services/country_code_api_services.dart';

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
