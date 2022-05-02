import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({Key? key}) : super(key: key);

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  TextEditingController nameController = TextEditingController();
  DateTime _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text('Employees'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    color: Colors.black, style: BorderStyle.solid, width: 1),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  items: <String>['All', 'Active', 'Inactive', 'Unverified']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3.5,
              height: 50.0,
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              margin: const EdgeInsets.all(20),
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
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              height: 50.0,
              width: MediaQuery.of(context).size.width / 5.5,
              child: ElevatedButton(
                child: const Text("open picker dialog"),
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
                    color: Colors.red,
                  ),
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  elevation: 0,
                ),
              ),
            ),
            Container(
              height: 50.0,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('+ADD NEW EMPLOYEE'),
              ),
            ),
          ],
        )
      ],
    );
  }
}
