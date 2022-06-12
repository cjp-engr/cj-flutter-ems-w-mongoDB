import 'package:ems_app/utils/bloc_provider_list.dart';
import 'package:ems_app/utils/repository_provider_list.dart';

import '../../constants/constants.dart';
import '../../widgets/side_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: repositoryProviderList(context),
      child: MultiBlocProvider(
        providers: blocProviderList(context),
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
