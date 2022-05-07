import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';

class EmployeeSetHours extends StatefulWidget {
  const EmployeeSetHours({Key? key}) : super(key: key);

  @override
  State<EmployeeSetHours> createState() => _EmployeeSetHoursState();
}

class _EmployeeSetHoursState extends State<EmployeeSetHours> {
  TimeOfDay _time = TimeOfDay.now().replacing(hour: 11, minute: 30);

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 1.75,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            createInlinePicker(
              elevation: 1,
              value: _time,
              onChange: onTimeChanged,
              minuteInterval: MinuteInterval.ONE,
              minHour: 0,
              maxHour: 23,
              hourLabel: '',
              minuteLabel: '',
              is24HrFormat: false,
              dialogInsetPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
