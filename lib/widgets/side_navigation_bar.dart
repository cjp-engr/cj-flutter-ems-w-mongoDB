import '../../blocs/blocs.dart';
import '../../constants/constants.dart';
import '../../pages/dashboard_page.dart';
import '../../pages/employee_page.dart';
import '../../pages/employees_page.dart';
import '../../widgets/switch_user_page/switch_pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideNavigationBar extends StatelessWidget {
  const SideNavigationBar({Key? key}) : super(key: key);
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    EmployeePage(),
    EmployeesPage(),
    ShowPinDialog(),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                      child: Icon(
                        Icons.notes,
                        size: 100,
                        color: darkBlueText,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<SideNavigationBloc>()
                          .add(const SwitchActivePageEvent(activePage: 1));
                    },
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: darkBlueText,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<SideNavigationBloc>()
                          .add(const SwitchActivePageEvent(activePage: 2));
                    },
                    child: Icon(
                      Icons.note_sharp,
                      size: 100,
                      color: darkBlueText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 150),
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) => const SwitchPin(),
                        );
                      },
                      child: Icon(
                        Icons.switch_account_outlined,
                        size: 100,
                        color: darkBlueText,
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
      ),
    );
  }
}

class ShowPinDialog extends StatelessWidget {
  const ShowPinDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () => showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => const SwitchPin(),
      ),
    );
    return Container();
  }
}
