import 'package:ems_app/blocs/attendance/attendance_bloc.dart';
import 'package:ems_app/blocs/employee_details/employee_details_bloc.dart';
import 'package:ems_app/blocs/employees/employees_bloc.dart';
import 'package:ems_app/constants/constants.dart';
import 'package:ems_app/widgets/employees_page/employee_view_hours_dialog.dart';
import 'package:ems_app/widgets/employees_page/show_info_employee_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesList extends StatelessWidget {
  const EmployeesList({Key? key}) : super(key: key);

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
                      width: 155,
                    ),
                    Text('CONTACT INFORMATION'),
                    SizedBox(
                      width: 190,
                    ),
                    Text('SCHEDULE'),
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
              context.read<EmployeeDetailsBloc>().add(FetchIdEvent(
                    id: state.employeesList[index].id!,
                  ));
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const ShowInfoEmployeeDialog(),
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
                    width: MediaQuery.of(context).size.width / 4.5,
                    child: Column(
                      children: [
                        Text(state.employeesList[index].email!),
                        Text(state.employeesList[index].phoneNumber!),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: const [
                                Text('Break Time'),
                                Text('00H 00M'),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: const [
                                Text('Time Worked'),
                                Text('00H 00M'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: redButton,
                            ),
                            onPressed: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) =>
                                    const EmployeeViewHoursDialog(),
                              );
                              context
                                  .read<AttendanceBloc>()
                                  .add(GetEmployeeDetailsEvent(
                                    uniqueId: state.employeesList[index].id!,
                                    firstName:
                                        state.employeesList[index].firstName!,
                                    lastName:
                                        state.employeesList[index].lastName!,
                                    employeeId:
                                        state.employeesList[index].employeeId!,
                                  ));
                            },
                            child: Text(
                              'VIEW HOURS',
                              style:
                                  Theme.of(context).textTheme.bodyText1!.merge(
                                        TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: darkBlueText,
                                        ),
                                      ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
