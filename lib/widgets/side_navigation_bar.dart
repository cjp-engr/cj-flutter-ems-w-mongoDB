import 'package:ems_app/pages/dashboard_page.dart';
import 'package:ems_app/pages/employees_page.dart';
import 'package:flutter/material.dart';

class SideNavigationBar extends StatelessWidget {
  const SideNavigationBar({Key? key}) : super(key: key);
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    EmployeesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notes,
                    size: 100,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person,
                    size: 100,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: Column(
              children: [
                _widgetOptions[1],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
