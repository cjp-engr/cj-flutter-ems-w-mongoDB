import '../../widgets/employees_page/employees_headers.dart';
import '../../widgets/employees_page/employees_list.dart';
import 'package:flutter/material.dart';

class EmployeesPage extends StatelessWidget {
  const EmployeesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        EmployeesHeaders(),
        EmployeesList(),
      ],
    );
  }
}
