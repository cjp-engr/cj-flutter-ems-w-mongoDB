import 'package:ems_app/widgets/payroll_page/show_info_payroll_dialog.dart';

import '../../blocs/attendance/attendance_bloc.dart';
import '../../blocs/employee_details/employee_details_bloc.dart';
import '../../blocs/employees/employees_bloc.dart';
import '../../constants/constants.dart';
import '../../widgets/employees_page/employee_view_hours_dialog.dart';
import '../../widgets/employees_page/show_info_employee_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayrollEmployeesList extends StatelessWidget {
  const PayrollEmployeesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              right: 20,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[400],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  right: 20,
                  left: 20,
                ),
                child: Row(
                  children: const [
                    SizedBox(
                      width: 70,
                    ),
                    Text('EMPLOYEE'),
                    SizedBox(
                      width: 120,
                    ),
                    Text('EMPLOYEE NO.'),
                    SizedBox(
                      width: 150,
                    ),
                    Text('RATE'),
                    SizedBox(
                      width: 150,
                    ),
                    Text('JOB ROLE'),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 30,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.6,
              child: BlocBuilder<EmployeesBloc, EmployeesState>(
                builder: (context, state) {
                  if (state.employeesListStatus ==
                          EmployeesListStatus.loading &&
                      state.employeesList.isEmpty) {
                    return const Text('Loading...');
                  } else if (state.employeesListStatus ==
                          EmployeesListStatus.loading &&
                      state.employeesList.isNotEmpty) {
                    return const EmployeesData();
                  }

                  if (state.employeesListStatus == EmployeesListStatus.error) {
                    return const Text('There is an error...');
                  }

                  return const EmployeesData();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmployeesData extends StatelessWidget {
  const EmployeesData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeesBloc, EmployeesState>(
      builder: (context, state) {
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: Colors.black,
          ),
          itemCount: state.employeesList.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const ShowInfoPayrollDialog(),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4.5,
                    child: Row(
                      children: [
                        ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(27), // Image radius
                            child: state.employeesList[index].imageUrl == ''
                                ? Image.asset(
                                    'assets/images/flutter_logo.png',
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    state.employeesList[index].imageUrl!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.employeesList[index].firstName! +
                                  " " +
                                  state.employeesList[index].lastName!,
                              style: Theme.of(context).textTheme.bodyText2,
                              maxLines: 2,
                            ),
                            Text(
                              state.employeesList[index].jobRole!,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.055,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Text(state.employeesList[index].employeeId! + ' '),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.13,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Text(
                        state.employeesList[index].hourlyRate!.toString() +
                            ' '),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Text(
                      state.employeesList[index].jobRole! + ' ',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.005,
                  ),
                ],
              ),
            ),
          ),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
        );
      },
    );
  }
}
