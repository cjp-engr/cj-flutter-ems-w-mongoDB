import 'dart:developer';

import 'package:ems_app/blocs/attendance/attendance_bloc.dart';
import 'package:ems_app/constants/constants.dart';
import 'package:ems_app/widgets/employees_page/employee_view_hours_entry_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EmployeeViewHoursDialog extends StatelessWidget {
  const EmployeeViewHoursDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width / 1.7,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Text(
              'TOTAL WORK TIME',
              style: Theme.of(context).textTheme.headline5!.merge(
                    const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
            Text(
              '00:00',
              style: Theme.of(context).textTheme.headline5!.merge(
                    const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.75,
              height: MediaQuery.of(context).size.height / 1.9,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const TimeWorkedList(),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 70,
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            const EmployeeViewHoursEntryDialog(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: redButton,
                    ),
                    child: Text(
                      'ADD',
                      style: Theme.of(context).textTheme.bodyText1!.merge(
                            TextStyle(
                              fontWeight: FontWeight.bold,
                              color: darkBlueText,
                              fontSize: 30,
                            ),
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.read<AttendanceBloc>().add(ClearDetailsEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      primary: yellowButton,
                    ),
                    child: Text(
                      'DONE',
                      style: Theme.of(context).textTheme.bodyText1!.merge(
                            TextStyle(
                              fontWeight: FontWeight.bold,
                              color: darkBlueText,
                              fontSize: 30,
                            ),
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimeWorkedList extends StatelessWidget {
  const TimeWorkedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _showStartTime(final a) async {
      final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      final DateTime dateSelected =
          BlocProvider.of<AttendanceBloc>(context).state.workDate;
      if (result != null) {
        var startTime = DateTime(
          dateSelected.year,
          dateSelected.month,
          dateSelected.day,
          result.hour,
          result.minute,
        );
        context.read<AttendanceBloc>().add(UpdateWorkedStartTimeEvent(
              att: a,
              startTime: startTime,
            ));
      }
    }

    Future<void> _showEndTime(String id) async {
      final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (result != null) {
        //log(result.format(context));
      }
    }

    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        if (state.attStatus == AttendanceStatus.reading ||
            state.attStatus == AttendanceStatus.adding ||
            state.attStatus == AttendanceStatus.updating) {
          return const Center(child: Text('Loading'));
        }
        return ListView.builder(
          itemCount: state.attendanceList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 70,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          _showStartTime(state.attendanceList[index]);
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(color: darkBlueText, width: 2.5),
                          primary: Colors.white,
                        ),
                        child: Text(
                          DateFormat('h:mm a').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                state.attendanceList[index].clockin!),
                          ),
                          style: Theme.of(context).textTheme.bodyText1!.merge(
                                TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: darkBlueText,
                                  fontSize: 40,
                                ),
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 70,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          _showEndTime(state.attendanceList[index].id!);
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(color: darkBlueText, width: 2.5),
                          primary: Colors.white,
                        ),
                        child: Text(
                          DateFormat('h:mm a').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                state.attendanceList[index].clockout!),
                          ),
                          style: Theme.of(context).textTheme.bodyText1!.merge(
                                TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: darkBlueText,
                                  fontSize: 40,
                                ),
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    SizedBox(
                      height: 70,
                      width: 80,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: redButton,
                        ),
                        child: Icon(
                          Icons.delete_outline_outlined,
                          size: 50,
                          color: darkBlueText,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        );
      },
    );
  }
}
