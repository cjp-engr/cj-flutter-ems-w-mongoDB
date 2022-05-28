import 'package:ems_app/blocs/attendance/attendance_bloc.dart';
import 'package:ems_app/blocs/blocs.dart';
import 'package:ems_app/constants/constants.dart';
import 'package:ems_app/widgets/employees_page/show_info_employee_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesHeaders extends StatefulWidget {
  const EmployeesHeaders({Key? key}) : super(key: key);

  @override
  State<EmployeesHeaders> createState() => _EmployeesHeadersState();
}

class _EmployeesHeadersState extends State<EmployeesHeaders> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    _initLoadEmployee();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _initLoadEmployee() {
    context.read<EmployeesBloc>().add(FetchAllEmployeesEvent());
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = context.watch<AttendanceBloc>().state.workDate;
    void _showDatePicker() {
      showCupertinoModalPopup(
          context: context,
          builder: (BuildContext builder) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 220),
              child: Stack(
                children: [
                  Container(
                    height:
                        MediaQuery.of(context).copyWith().size.height * 0.42,
                    width: MediaQuery.of(context).copyWith().size.height * 0.38,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                    ),
                    child: Text(
                      'Select Date',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        right: 5,
                        bottom: 5,
                      ),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              context.read<AttendanceBloc>().add(
                                  GetSelectedDateEvent(
                                      selectedDate: DateTime.now()));
                            },
                            child: const Text('Current Date'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              context.read<AttendanceBloc>().add(
                                  GetSelectedDateEvent(
                                      selectedDate: selectedDate));
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).copyWith().size.height * 0.30,
                      width:
                          MediaQuery.of(context).copyWith().size.height * 0.38,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (value) {
                          setState(() {
                            selectedDate = value;
                          });
                        },
                        minimumYear: 1970,
                        maximumDate: DateTime.now(),
                        maximumYear: DateTime.now().year,
                        initialDateTime: selectedDate,
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    }

    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 40,
              bottom: 30,
            ),
            child: Text(
              'EMPLOYEES',
              style: Theme.of(context).textTheme.headline5!.merge(
                    const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: 50.0,
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              //margin: const EdgeInsets.all(20),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  labelText: 'Filter by Employee Name...',
                ),
                onChanged: (text) {
                  setState(() {});
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              height: 50.0,
              width: MediaQuery.of(context).size.width / 6,
              child: ElevatedButton(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 1),
                      child: Text(
                        selectedDate.month.toString() +
                            "/" +
                            selectedDate.day.toString() +
                            "/" +
                            selectedDate.year.toString(),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                    const Icon(Icons.calendar_month_outlined),
                  ],
                ),
                onPressed: _showDatePicker,
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    width: 2.5,
                    color: darkBlueText,
                  ),
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  elevation: 0,
                ),
              ),
            ),
            Container(
              height: 50.0,
              padding: const EdgeInsets.only(left: 2, right: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 3.8,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<EmployeeDetailsBloc>().add(
                          const FetchIdEvent(
                            id: "addingNewEmployee",
                          ),
                        );
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => const ShowInfoEmployeeDialog(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: yellowButton,
                  ),
                  child: Text(
                    '+ ADD NEW EMPLOYEE',
                    style: Theme.of(context).textTheme.bodyText1!.merge(
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            color: darkBlueText,
                          ),
                        ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
