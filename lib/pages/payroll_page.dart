import 'package:ems_app/widgets/payroll_page/pr_employees_list.dart';
import 'package:ems_app/widgets/payroll_page/pr_headers.dart';
import 'package:flutter/material.dart';

class PayrollPage extends StatelessWidget {
  const PayrollPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        PayrollHeaders(),
        PayrollEmployeesList(),
      ],
    );
  }
}
