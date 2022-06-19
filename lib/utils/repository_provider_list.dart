import 'package:ems_app/repositories/attendance_repository.dart';
import 'package:ems_app/repositories/country_code_repository.dart';
import 'package:ems_app/repositories/employee_repository.dart';
import 'package:ems_app/repositories/payroll_repository.dart';
import 'package:ems_app/repositories/weather_repository.dart';
import 'package:ems_app/services/attendance_api_services.dart';
import 'package:ems_app/services/country_code_api_services.dart';
import 'package:ems_app/services/employee_api_services.dart';
import 'package:ems_app/services/payroll_api_services.dart';
import 'package:ems_app/services/weather_api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

List<RepositoryProvider> repositoryProviderList(BuildContext context) {
  return [
    RepositoryProvider<CountryCodeRepository>(
      create: (context) => CountryCodeRepository(
        countryCodeApiServices: CountryCodeApiServices(
          httpClient: http.Client(),
        ),
      ),
    ),
    RepositoryProvider<EmployeeRepository>(
      create: (context) => EmployeeRepository(
        employeeApiServices: EmployeeApiServices(
          httpClient: http.Client(),
        ),
      ),
    ),
    RepositoryProvider<AttendanceRepository>(
      create: (context) => AttendanceRepository(
        attendanceApiServices: AttendanceApiServices(
          httpClient: http.Client(),
        ),
      ),
    ),
    RepositoryProvider<PayrollRepository>(
      create: (context) => PayrollRepository(
        payrollApiServices: PayrollApiServices(
          httpClient: http.Client(),
        ),
      ),
    ),
    RepositoryProvider<WeatherRepository>(
      create: (context) => WeatherRepository(
        weatherApiServices: WeatherApiServices(
          httpClient: http.Client(),
        ),
      ),
    ),
  ];
}
