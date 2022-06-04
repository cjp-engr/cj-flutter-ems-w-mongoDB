import '../../blocs/blocs.dart';
import '../../constants/constants.dart';
import '../../repositories/attendance_repository.dart';
import '../../repositories/country_code_repository.dart';
import '../../repositories/employee_repository.dart';
import '../../services/attendance_api_services.dart';
import '../../services/country_code_api_services.dart';
import '../../services/employee_api_services.dart';
import '../../widgets/side_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => CountryCodeRepository(
            countryCodeApiServices: CountryCodeApiServices(
              httpClient: http.Client(),
            ),
          ),
        ),
        RepositoryProvider(
          create: (context) => EmployeeRepository(
            employeeApiServices: EmployeeApiServices(
              httpClient: http.Client(),
            ),
          ),
        ),
        RepositoryProvider(
          create: (context) => AttendanceRepository(
            attendanceApiServices: AttendanceApiServices(
              httpClient: http.Client(),
            ),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<EmployeeDetailsBloc>(
            create: (context) => EmployeeDetailsBloc(
              employeeRepository: context.read<EmployeeRepository>(),
            ),
          ),
          BlocProvider<CountryCodesBloc>(
            create: (context) => CountryCodesBloc(
              countryCodeRepository: context.read<CountryCodeRepository>(),
              employeeDetailsBloc:
                  BlocProvider.of<EmployeeDetailsBloc>(context),
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
            create: (context) => AttendanceTimeWorkedBloc(
              attendanceRepository: context.read<AttendanceRepository>(),
            ),
          ),
          BlocProvider<AttendanceTodayBloc>(
            create: (context) => AttendanceTodayBloc(
              employeeRepository: context.read<EmployeeRepository>(),
              attendanceRepository: context.read<AttendanceRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            cupertinoOverrideTheme: const CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20.0,
                ),
              ),
            ),
            timePickerTheme: TimePickerThemeData(
              hourMinuteTextStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                color: darkBlueText,
              ),
              dayPeriodTextStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: darkBlueText,
              ),
            ),
            textTheme: const TextTheme(
              button: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
              headline5: TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.w600,
              ),
              headline6: TextStyle(
                fontSize: 26.5,
                fontWeight: FontWeight.w600,
              ),
              subtitle1: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w400,
              ),
              subtitle2: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.w400,
              ),
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
              bodyText2: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
              caption: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.w300,
              ),
            ).apply(
              fontFamily: 'Poppins',
            ),
          ),
          home: const SideNavigationBar(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
