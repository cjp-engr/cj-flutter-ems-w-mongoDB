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
    void _showDateFromPicker() {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return const ShowDateFromPicker();
        },
      );
    }

    void _showDateToPicker() {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return const ShowDateToPicker();
        },
      );
    }

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
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 1),
                          //From Date
                          child: BlocBuilder<PayrollBloc, PayrollState>(
                            builder: (context, state) {
                              return Text(state.dateFrom.month.toString() +
                                  '/' +
                                  state.dateFrom.day.toString() +
                                  '/' +
                                  state.dateFrom.year.toString());
                            },
                          ),
                        ),
                        //Icon(Icons.arrow_drop_down),
                        const Icon(Icons.calendar_month_outlined),
                      ],
                    ),
                    onPressed: _showDateFromPicker,
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 1),
                          //To Date
                          child: BlocBuilder<PayrollBloc, PayrollState>(
                            builder: (context, state) {
                              return Text(state.dateTo.month.toString() +
                                  '/' +
                                  state.dateTo.day.toString() +
                                  '/' +
                                  state.dateTo.year.toString());
                            },
                          ),
                        ),
                        //Icon(Icons.arrow_drop_down),
                        const Icon(Icons.calendar_month_outlined),
                      ],
                    ),
                    onPressed: _showDateToPicker,
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

class ShowDateFromPicker extends StatelessWidget {
  const ShowDateFromPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateFrom = context.watch<PayrollBloc>().state.dateFrom;
    return Padding(
      padding: const EdgeInsets.only(bottom: 220),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.42,
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
                      context.read<PayrollBloc>().add(
                            GetDateFromEvent(
                              selectedDate: DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                              ),
                            ),
                          );
                      Navigator.of(context).pop();
                    },
                    child: const Text('Current Date'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<PayrollBloc>().add(
                            GetDateFromEvent(
                              selectedDate: dateFrom,
                            ),
                          );
                      Navigator.of(context).pop();
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
              height: MediaQuery.of(context).copyWith().size.height * 0.30,
              width: MediaQuery.of(context).copyWith().size.height * 0.38,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  dateFrom = value;
                },
                minimumYear: 1970,
                maximumDate: DateTime.now(),
                maximumYear: DateTime.now().year,
                initialDateTime: dateFrom,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowDateToPicker extends StatelessWidget {
  const ShowDateToPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = context.watch<PayrollBloc>().state.dateTo;

    return Padding(
      padding: const EdgeInsets.only(bottom: 220),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.42,
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
                      context.read<PayrollBloc>().add(
                            GetDateToEvent(
                              selectedDate: DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                              ),
                            ),
                          );
                    },
                    child: const Text('Current Date'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<PayrollBloc>().add(
                            GetDateToEvent(
                              selectedDate: selectedDate,
                            ),
                          );
                      Navigator.of(context).pop();
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
              height: MediaQuery.of(context).copyWith().size.height * 0.30,
              width: MediaQuery.of(context).copyWith().size.height * 0.38,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  selectedDate = value;
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
  }
}
