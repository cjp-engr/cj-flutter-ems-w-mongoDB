import 'package:ems_app/blocs/attendance_today/attendance_today_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import 'package:flutter/material.dart';

class IsNotEnteredDialog extends StatelessWidget {
  const IsNotEnteredDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.height / 3.5,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<AttendanceTodayBloc, AttendanceTodayState>(
              builder: (context, state) {
                if (state.enterStatus == EnterTodayPinStatus.isNotManager) {
                  return const Text(
                    'You do not have access.',
                    textAlign: TextAlign.center,
                  );
                }
                if (state.enterStatus == EnterTodayPinStatus.isNotExisting ||
                    state.enterStatus == EnterTodayPinStatus.isNotEntered) {
                  return const Text(
                    'You entered a wrong PIN',
                    textAlign: TextAlign.center,
                  );
                }
                return const SizedBox();
              },
            ),
            SizedBox(
              height: 80,
              width: 130,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);

                  context
                      .read<AttendanceTodayBloc>()
                      .add(const IsEmployeeEnteredEvent(isEntered: false));
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
        ),
      ),
    );
  }
}
