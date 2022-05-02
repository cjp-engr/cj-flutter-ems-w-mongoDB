import 'package:ems_app/widgets/side_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          button: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
          ),
          headline5: TextStyle(
            fontSize: 45.0,
            fontWeight: FontWeight.w400,
          ),
          headline6: TextStyle(
            fontSize: 26.5,
            fontWeight: FontWeight.w400,
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
            fontSize: 21.0,
            fontWeight: FontWeight.w400,
          ),
          bodyText2: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.w400,
          ),
          caption: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.w300,
          ),
        ).apply(
          fontFamily: 'Questrial',
        ),
      ),
      home: const SideNavigationBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}
