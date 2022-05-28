import 'package:ems_app/blocs/attendance/attendance_bloc.dart';
import 'package:ems_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EmployeeViewHoursEntryDialog extends StatelessWidget {
  const EmployeeViewHoursEntryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _showStartTime() async {
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
        //log(newDate.millisecondsSinceEpoch.toString());
        context
            .read<AttendanceBloc>()
            .add(GetWorkedStartTimeEvent(startTime: startTime));
      }
    }

    Future<void> _showEndTime() async {
      final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
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
        context
            .read<AttendanceBloc>()
            .add(GetWorkedEndTimeEvent(endTime: endTime));
      }
    }

    return SimpleDialog(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 2.3,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Text(
                'ADD TIME',
                style: Theme.of(context).textTheme.headline5!.merge(
                      const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                      top: 30,
                    ),
                    child: SizedBox(
                      height: 70,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: _showStartTime,
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(color: darkBlueText, width: 2.5),
                          primary: Colors.white,
                        ),
                        child: BlocBuilder<AttendanceBloc, AttendanceState>(
                          builder: (context, state) {
                            return Text(
                              state.clockin == DateTime(1970, 1, 1)
                                  ? 'Start'
                                  : DateFormat('h:mm a').format(state.clockin),
                              style:
                                  Theme.of(context).textTheme.bodyText1!.merge(
                                        TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: darkBlueText,
                                          fontSize: 40,
                                        ),
                                      ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 40,
                      top: 30,
                    ),
                    child: SizedBox(
                      height: 70,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: _showEndTime,
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(color: darkBlueText, width: 2.5),
                          primary: Colors.white,
                        ),
                        child: BlocBuilder<AttendanceBloc, AttendanceState>(
                          builder: (context, state) {
                            return Text(
                              state.clockout == DateTime(1970, 1, 1)
                                  ? 'End'
                                  : DateFormat('h:mm a').format(state.clockout),
                              style:
                                  Theme.of(context).textTheme.bodyText1!.merge(
                                        TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: darkBlueText,
                                          fontSize: 40,
                                        ),
                                      ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                    width: 160,
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<AttendanceBloc>()
                            .add(AddWorkedTimeEvent());
                        Navigator.of(context).pop();
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
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 70,
                    width: 160,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: redButton,
                      ),
                      child: Text(
                        'CANCEL',
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
      ],
    );
  }
}
