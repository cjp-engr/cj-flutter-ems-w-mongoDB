import 'package:ems_app/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import 'package:flutter/material.dart';

class ClockoutConfirmationDialog extends StatelessWidget {
  const ClockoutConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.height / 3.5,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: BlocBuilder<AttendanceTodayBloc, AttendanceTodayState>(
          builder: (context, state) {
            if (state.attTodayStatus == AttendanceTodayPinStatus.loading) {
              return Column(
                children: const [
                  Text('Loading'),
                ],
              );
            }

            if (state.attTodayStatus ==
                AttendanceTodayPinStatus.isNotExisting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'You entered a wrong PIN!',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 80,
                    width: 130,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: darkBlueText,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: yellowButton,
                      ),
                    ),
                  ),
                ],
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Are you sure you want to clock out?',
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 80,
                      width: 130,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'NO',
                          style: TextStyle(
                            color: darkBlueText,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: yellowButton,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 130,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'YES',
                          style: TextStyle(
                            color: darkBlueText,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: redButton,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
