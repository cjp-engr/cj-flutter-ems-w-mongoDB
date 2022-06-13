import '../../blocs/blocs.dart';
import '../../constants/constants.dart';
import '../../widgets/employees_page/employee_view_hours_entry_dialog.dart';
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
            //TODO: Add Date selected
            BlocBuilder<AttendanceTimeWorkedBloc, AttendanceTimeWorkedState>(
              builder: (context, state) {
                return int.tryParse(state.hours)! < 0 &&
                        int.tryParse(state.minutes)! < 0
                    ? const Text('Hello')
                    : Text(
                        state.hours + 'H ' + state.minutes + 'M',
                        style: Theme.of(context).textTheme.headline5!.merge(
                              const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      );
              },
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
            BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, state) {
                return state.workDate !=
                        DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                        )
                    ? Row(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .merge(
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
                                context
                                    .read<AttendanceBloc>()
                                    .add(ClearDetailsEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                primary: yellowButton,
                              ),
                              child: Text(
                                'DONE',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .merge(
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
                      )
                    : SizedBox(
                        height: 70,
                        width: 160,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            context
                                .read<AttendanceBloc>()
                                .add(ClearDetailsEvent());
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
                      );
              },
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
    Future<void> _showStartTime(
      final attendance,
      int initHour,
      int initMinute,
    ) async {
      final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: initHour,
          minute: initMinute,
        ),
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
              att: attendance,
              startTime: startTime,
            ));
      }
    }

    Future<void> _showEndTime(
      final attendance,
      int initHour,
      int initMinute,
    ) async {
      final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: initHour,
          minute: initMinute,
        ),
      );
      final DateTime dateSelected =
          BlocProvider.of<AttendanceBloc>(context).state.workDate;
      if (result != null) {
        var endTime = DateTime(
          dateSelected.year,
          dateSelected.month,
          dateSelected.day,
          result.hour,
          result.minute,
        );
        context.read<AttendanceBloc>().add(UpdateWorkedEndTimeEvent(
              att: attendance,
              endTime: endTime,
            ));
      }
    }

    int? clockInMinute(int x) {
      return int.tryParse(
          DateFormat('mm').format(DateTime.fromMillisecondsSinceEpoch(x)));
    }

    int? clockInHour(int x) {
      if (DateFormat('a').format(DateTime.fromMillisecondsSinceEpoch(x)) ==
          'AM') {
        return int.tryParse(
            DateFormat('h').format(DateTime.fromMillisecondsSinceEpoch(x)));
      } else {
        return int.tryParse(DateFormat('h')
                .format(DateTime.fromMillisecondsSinceEpoch(x)))! +
            12;
      }
    }

    int? clockOutMinute(int x) {
      return int.tryParse(
          DateFormat('mm').format(DateTime.fromMillisecondsSinceEpoch(x)));
    }

    int? clockOutHour(int x) {
      if (DateFormat('a').format(DateTime.fromMillisecondsSinceEpoch(x)) ==
          'AM') {
        return int.tryParse(
            DateFormat('h').format(DateTime.fromMillisecondsSinceEpoch(x)));
      } else {
        return int.tryParse(DateFormat('h')
                .format(DateTime.fromMillisecondsSinceEpoch(x)))! +
            12;
      }
    }

    return BlocListener<AttendanceBloc, AttendanceState>(
      listener: (context, stateListen) {
        int hoursWorked = 0;
        for (var item in stateListen.attendanceList) {
          if (item.clockout! > 0) {
            hoursWorked += (item.clockout! - item.clockin!);
          } else {
            int now = DateTime.now().millisecondsSinceEpoch;

            hoursWorked += (now - item.clockin!);
          }

          //hoursWorked += (item.clockout! - item.clockin!);
        }

        final duration = Duration(seconds: (hoursWorked * 0.001).toInt());
        context
            .read<AttendanceTimeWorkedBloc>()
            .add(GetTimeWorkedEvent(duration: duration));
      },
      child: BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
          if (state.attStatus == AttendanceStatus.reading ||
              state.attStatus == AttendanceStatus.adding ||
              state.attStatus == AttendanceStatus.updating) {
            return const Center(child: Text('Loading'));
          }
          return ListView.builder(
            itemCount: state.attendanceList.length,
            itemBuilder: (BuildContext context, int index) {
              int epochClockIn = state.attendanceList[index].clockin!;
              int epochClockOut = state.attendanceList[index].clockout!;
              int clockInH = clockInHour(epochClockIn)!;
              int clockInM = clockInMinute(epochClockIn)!;
              int clockOutH = clockOutHour(epochClockOut)!;
              int clockOutM = clockOutMinute(epochClockOut)!;

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 65,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            _showStartTime(
                              state.attendanceList[index],
                              clockInH,
                              clockInM,
                            );
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
                                    fontSize: 35,
                                  ),
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 65,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            _showEndTime(
                              state.attendanceList[index],
                              clockOutH,
                              clockOutM,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(color: darkBlueText, width: 2.5),
                            primary: Colors.white,
                          ),
                          child: state.attendanceList[index].clockout == -1
                              ? Text(
                                  'still working...',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .merge(
                                        TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: darkBlueText,
                                          fontSize: 20,
                                        ),
                                      ),
                                )
                              : Text(
                                  DateFormat('h:mm a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        state.attendanceList[index].clockout!),
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .merge(
                                        TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: darkBlueText,
                                          fontSize: 35,
                                        ),
                                      ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      SizedBox(
                        height: 65,
                        width: 80,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AttendanceBloc>().add(
                                DeleteWorkedTimeEvent(
                                    id: state.attendanceList[index].id!));
                          },
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
      ),
    );
  }
}
