import 'package:ems_app/blocs/side_navigation/side_navigation_bloc.dart';
import 'package:ems_app/pages/dashboard_page.dart';
import 'package:ems_app/pages/employee_page.dart';
import 'package:ems_app/pages/employees_page.dart';
import 'package:ems_app/pages/switch_user_page.dart';
import 'package:ems_app/widgets/switch_user_page/switch_pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideNavigationBar extends StatelessWidget {
  const SideNavigationBar({Key? key}) : super(key: key);
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    EmployeePage(),
    EmployeesPage(),
    SwitchUserPage(),
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
                  child: TextButton(
                    onPressed: () {
                      context
                          .read<SideNavigationBloc>()
                          .add(const SwitchActivePageEvent(activePage: 0));
                    },
                    child: const Icon(
                      Icons.notes,
                      size: 100,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context
                        .read<SideNavigationBloc>()
                        .add(const SwitchActivePageEvent(activePage: 1));
                  },
                  child: const Icon(
                    Icons.person,
                    size: 100,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context
                        .read<SideNavigationBloc>()
                        .add(const SwitchActivePageEvent(activePage: 2));
                  },
                  child: const Icon(
                    Icons.note_sharp,
                    size: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 150),
                  child: TextButton(
                    onPressed: () {
                      // context
                      //     .read<SideNavigationBloc>()
                      //     .add(const SwitchActivePageEvent(activePage: 3));
                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) => const SwitchPin(),
                      );
                    },
                    child: const Icon(
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
                _widgetOptions[
                    context.watch<SideNavigationBloc>().state.activePage],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
