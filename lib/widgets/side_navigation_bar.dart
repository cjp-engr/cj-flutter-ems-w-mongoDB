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
      resizeToAvoidBottomInset: false,
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notes,
                      size: 100,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person,
                    size: 100,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.note_sharp,
                    size: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 150),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.switch_account_outlined,
                      size: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 15,
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
