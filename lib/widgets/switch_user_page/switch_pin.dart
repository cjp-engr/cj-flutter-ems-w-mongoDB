import 'package:flutter/scheduler.dart';

import '../../blocs/blocs.dart';
import '../../constants/constants.dart';
import '../../widgets/switch_user_page/clockin_confirmation_dialog.dart';
import '../../widgets/switch_user_page/clockout_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SwitchPin extends StatelessWidget {
  const SwitchPin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceTodayBloc, AttendanceTodayState>(
      builder: (context, state) {
        if (state.enterStatus == EnterTodayPinStatus.isManager) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pop();
          });

          context
              .read<AttendanceTodayBloc>()
              .add(const IsEmployeeEnteredEvent(isEntered: true));
        }
        if (state.enterStatus == EnterTodayPinStatus.isNotEntered) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("You entered an incorrect PIN!"),
              duration: Duration(seconds: 1),
            ));
          });
        }

        return SimpleDialog(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.4,
                  height: MediaQuery.of(context).size.height / 1.3,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          color: Colors.red,
                        ),
                      ),
                      StreamBuilder(
                        stream: Stream.periodic(const Duration(seconds: 1)),
                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              Text(
                                DateFormat('h:mm a').format(DateTime.now()),
                                style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  color: darkBlueText,
                                ),
                              ),
                              Text(
                                DateFormat('E, MMM d, yyyy')
                                    .format(DateTime.now()),
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: darkBlueText,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.4,
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: Column(
                    children: [
                      PinEntered(
                        pinLen: state.pinLength,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 350,
                        width: 400,
                        child: GridView.count(
                          shrinkWrap: true,
                          childAspectRatio: 1.6,
                          crossAxisCount: 3,
                          controller: ScrollController(
                            keepScrollOffset: false,
                          ),
                          children: [
                            for (int index = 1; index <= 9; index++)
                              PinKey(character: index.toString()),
                            const PinKey(character: '0'),
                            const PinKey(character: '00'),
                            const PinKey(character: 'C'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 80,
                              width: 130,
                              child: ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<AttendanceTodayBloc>()
                                      .add(ClockInClickedEvent());

                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          const ClockinConfirmationDialog());
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: yellowButton,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'CLOCK',
                                      style: TextStyle(
                                        color: darkBlueText,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'IN',
                                      style: TextStyle(
                                        color: darkBlueText,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 80,
                              width: 130,
                              child: ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<AttendanceTodayBloc>()
                                      .add(EnterAttClickedEvent());
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: redButton,
                                ),
                                child: Text(
                                  'ENTER',
                                  style: TextStyle(
                                    color: darkBlueText,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 80,
                              width: 130,
                              child: ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<AttendanceTodayBloc>()
                                      .add(ClockOutClickedEvent());
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const ClockoutConfirmationDialog(),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: yellowButton,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'CLOCK',
                                      style: TextStyle(
                                        color: darkBlueText,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'OUT',
                                      style: TextStyle(
                                        color: darkBlueText,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class PinEntered extends StatelessWidget {
  final int pinLen;
  const PinEntered({
    Key? key,
    required this.pinLen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return pinLen == 0 || pinLen == 4
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int index = 0; index < 4; index++)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 5.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                      ),
                      child: pinLen == 0
                          ? Image.asset('assets/images/asterisk_unfilled.png')
                          : Image.asset('assets/images/asterisk_filled.png'),
                    ),
                  ),
                ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int index = 0; index < pinLen; index++)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 5.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                      ),
                      child: Image.asset('assets/images/asterisk_filled.png'),
                    ),
                  ),
                ),
              for (int index = pinLen; index < 4; index++)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 5.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                      ),
                      child: Image.asset('assets/images/asterisk_unfilled.png'),
                    ),
                  ),
                ),
            ],
          );
  }
}

class PinKey extends StatelessWidget {
  final String character;

  const PinKey({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        height: 350,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.5,
            color: darkBlueText,
          ),
        ),
        child: TextButton(
          onPressed: () {
            context
                .read<AttendanceTodayBloc>()
                .add(EnterAttendancePinEvent(enteredPIN: character));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                character,
                style: TextStyle(
                  color: darkBlueText,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
