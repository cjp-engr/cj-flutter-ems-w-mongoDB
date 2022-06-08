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
    List<String> month = [
      'January',
      'Febraury',
      'March',
      'April',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    void _showMonthYearPicker() {
      showDialog(
          context: context,
          builder: (BuildContext builder) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 220),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: MediaQuery.of(context).copyWith().size.height *
                            0.42,
                        width: MediaQuery.of(context).copyWith().size.height *
                            0.45,
                        color: Colors.white,
                        child: Column(
                          children: [
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
                            SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height *
                                        0.25,
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height *
                                        0.20,
                                    child: CupertinoPicker(
                                      itemExtent: 32,
                                      onSelectedItemChanged: (value) {
                                        log(month[value]);
                                      },
                                      children: [
                                        for (int i = 0; i < month.length; i++)
                                          Text(month[i]),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height *
                                        0.25,
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height *
                                        0.20,
                                    child: CupertinoPicker(
                                      itemExtent: 32,
                                      onSelectedItemChanged: (value) {},
                                      children: [
                                        for (int i = 0; i < 70; i++)
                                          Text((1970 + i).toString()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                right: 5,
                                bottom: 5,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // SizedBox(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(top: 10),
                  //         child: SizedBox(
                  //           height:
                  //               MediaQuery.of(context).copyWith().size.height *
                  //                   0.30,
                  //           width:
                  //               MediaQuery.of(context).copyWith().size.height *
                  //                   0.20,
                  //           child: CupertinoPicker(
                  //             itemExtent: 32,
                  //             onSelectedItemChanged: (value) {
                  //               log(test[value]);
                  //             },
                  //             children: const [
                  //               Text('Item1'),
                  //               Text('Item1'),
                  //               // Text('March'),
                  //               // Text('...'),
                  //               Text('Item1'),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(top: 10),
                  //         child: SizedBox(
                  //           height:
                  //               MediaQuery.of(context).copyWith().size.height *
                  //                   0.30,
                  //           width:
                  //               MediaQuery.of(context).copyWith().size.height *
                  //                   0.20,
                  //           child: CupertinoPicker(
                  //             itemExtent: 32,
                  //             onSelectedItemChanged: (value) {
                  //               log(test[value]);
                  //             },
                  //             children: const [
                  //               Text('Item2'),
                  //               Text('Item2'),
                  //               // Text('March'),
                  //               // Text('...'),
                  //               Text('Item2'),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              height: 50.0,
              width: MediaQuery.of(context).size.width / 4.5,
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 1),
                      child: Text('selected month'),
                    ),
                    //Icon(Icons.arrow_drop_down),
                    Icon(Icons.calendar_month_outlined),
                  ],
                ),
                onPressed: _showMonthYearPicker,
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
        )
      ],
    );
  }
}
