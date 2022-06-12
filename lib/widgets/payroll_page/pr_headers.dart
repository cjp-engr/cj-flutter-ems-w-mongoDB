import 'dart:developer';

import 'package:ems_app/blocs/blocs.dart';
import 'package:ems_app/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayrollHeaders extends StatefulWidget {
  const PayrollHeaders({Key? key}) : super(key: key);

  @override
  State<PayrollHeaders> createState() => _PayrollHeadersState();
}

class _PayrollHeadersState extends State<PayrollHeaders> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    _initLoadEmployee();
    super.initState();
    nameController = TextEditingController();
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
              bottom: 15,
            ),
            child: Text(
              'PAYROLL',
              style: Theme.of(context).textTheme.headline5!.merge(
                    const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
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
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'From:',
                  style: Theme.of(context).textTheme.bodyText1!.merge(
                        const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.21,
                  height: 50,
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 1),
                          child: Text('Current Date:'),
                        ),
                        //Icon(Icons.arrow_drop_down),
                        Icon(Icons.calendar_month_outlined),
                      ],
                    ),
                    onPressed: () {},
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
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To:',
                  style: Theme.of(context).textTheme.bodyText1!.merge(
                        const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.21,
                  height: 50,
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 1),
                          child: Text('Current Date:'),
                        ),
                        //Icon(Icons.arrow_drop_down),
                        Icon(Icons.calendar_month_outlined),
                      ],
                    ),
                    onPressed: () {},
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
              ],
            ),
          ],
        ),
      ],
    );
  }
}
