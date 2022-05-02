import 'package:flutter/cupertino.dart';
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
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.yellow,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  items: <String>['Hello', 'Firefox', 'Chrome', 'Edgeeee']
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
              width: 100,
              margin: const EdgeInsets.all(20),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Filter by Employee Name...',
                ),
                onChanged: (text) {
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              height: 100,
              width: 150,
              child: ElevatedButton(
                child: const Text("open picker dialog"),
                onPressed: () async {
                  var _dateTime = await DatePicker.showSimpleDatePicker(
                    context,
                    initialDate: DateTime(DateTime.now().year),
                    firstDate: DateTime(1970),
                    lastDate: DateTime(DateTime.now().year + 2),
                    dateFormat: "MMM-dd-yyyy",
                    locale: DateTimePickerLocale.en_us,
                    looping: false,
                  );

                  final snackBar =
                      SnackBar(content: Text("Date Picked $_dateTime"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Add New Employee'),
            ),
          ],
        )
      ],
    );
  }
}
