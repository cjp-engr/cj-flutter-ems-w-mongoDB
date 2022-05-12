import 'package:ems_app/blocs/blocs.dart';
import 'package:ems_app/constants/constants.dart';
import 'package:ems_app/models/employee.dart';
import 'package:ems_app/widgets/employees_page/show_info_employee_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class EmployeesHeaders extends StatefulWidget {
  const EmployeesHeaders({Key? key}) : super(key: key);

  @override
  State<EmployeesHeaders> createState() => _EmployeesHeadersState();
}

class _EmployeesHeadersState extends State<EmployeesHeaders> {
  TextEditingController nameController = TextEditingController();
  DateTime _dateTime = DateTime.now();

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
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 50),
                      child: Text('Date'),
                    ),
                    Icon(Icons.arrow_drop_down),
                    Icon(Icons.calendar_month_outlined),
                  ],
                ),
                onPressed: () async {
                  _dateTime = (await DatePicker.showSimpleDatePicker(
                        context,
                        initialDate: DateTime(DateTime.now().year),
                        firstDate: DateTime(1970),
                        lastDate: DateTime(DateTime.now().year + 2),
                        dateFormat: "MMM-dd-yyyy",
                        locale: DateTimePickerLocale.en_us,
                        looping: false,
                      ) ??
                      DateTime.now());

                  final snackBar =
                      SnackBar(content: Text("Date Picked $_dateTime"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    width: 1.0,
                    color: Colors.black,
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
                    showDialog(
                      context: context,
                      builder: (context) => ShowInfoEmployeeDialog(
                        employeeDetails: Employee.initial(),
                      ),
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
