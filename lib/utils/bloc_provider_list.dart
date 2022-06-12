import 'package:ems_app/blocs/blocs.dart';
import 'package:ems_app/repositories/attendance_repository.dart';
import 'package:ems_app/repositories/country_code_repository.dart';
import 'package:ems_app/repositories/employee_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> blocProviderList(BuildContext context) {
  return [
    BlocProvider<EmployeeDetailsBloc>(
      create: (context) => EmployeeDetailsBloc(
        employeeRepository: context.read<EmployeeRepository>(),
      ),
    ),
    BlocProvider<CountryCodesBloc>(
      create: (context) => CountryCodesBloc(
        countryCodeRepository: context.read<CountryCodeRepository>(),
        employeeDetailsBloc: BlocProvider.of<EmployeeDetailsBloc>(context),
      )..add(FetchAllCountryCodesEvent()),
    ),
    BlocProvider<EmployeePinBloc>(
      create: (context) => EmployeePinBloc(
        employeeRepository: context.read<EmployeeRepository>(),
      ),
    ),
    BlocProvider<EmployeesBloc>(
      create: (context) => EmployeesBloc(
        employeeRepository: context.read<EmployeeRepository>(),
        empDetailsBloc: BlocProvider.of<EmployeeDetailsBloc>(context),
      ),
    ),
    BlocProvider<EmployeeImageBloc>(
      create: (context) => EmployeeImageBloc(
        empDetailsBloc: BlocProvider.of<EmployeeDetailsBloc>(context),
      ),
    ),
    BlocProvider<SideNavigationBloc>(
      create: (context) => SideNavigationBloc(),
    ),
    BlocProvider<AttendanceBloc>(
      create: (context) => AttendanceBloc(
        attendanceRepository: context.read<AttendanceRepository>(),
      ),
    ),
    BlocProvider<AttendanceTimeWorkedBloc>(
      create: (context) => AttendanceTimeWorkedBloc(),
    ),
    BlocProvider<AttendanceTodayBloc>(
      create: (context) => AttendanceTodayBloc(
        employeeRepository: context.read<EmployeeRepository>(),
        attendanceRepository: context.read<AttendanceRepository>(),
      ),
    ),
  ];
}
