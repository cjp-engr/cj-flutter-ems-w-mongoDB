import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../constants/constants.dart';

class EmployeePinDialog extends StatelessWidget {
  const EmployeePinDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeePinBloc, EmployeePinState>(
      builder: (context, state) {
        if (state.empPinStatus == EmployeePinStatus.enteredAndReEnteredMatch) {
          Navigator.of(context).pop();
        }
        return SimpleDialog(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 1.3,
              child: Column(
                children: [
                  PinEntered(
                    pinLen: state.pinLength,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    state.empPinStatus == EmployeePinStatus.initial
                        ? 'Please enter your 4-digit PIN code'
                        : state.empPinStatus == EmployeePinStatus.isExisting
                            ? 'PIN already exists. Please try again.'
                            : state.empPinStatus ==
                                    EmployeePinStatus.isNotExisting
                                ? 'Please confirm your 4-digit PIN code'
                                : state.empPinStatus ==
                                            EmployeePinStatus
                                                .enteredAndReEnteredNotMatch &&
                                        state.empPinStatus ==
                                            EmployeePinStatus.isExisting
                                    ? 'PIN entered and reentered do not match.'
                                    : state.empPinStatus ==
                                            EmployeePinStatus
                                                .enteredAndReEnteredNotMatch
                                        ? 'PIN entered and reentered do not match.'
                                        : 'Please enter your 4-digit PIN code',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 5,
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
                  SizedBox(
                      width: 400,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: yellowButton,
                        ),
                        onPressed: state.pinLength < 4
                            ? null
                            : () {
                                context
                                    .read<EmployeePinBloc>()
                                    .add(EnterClickedEvent());
                              },
                        child: Text(
                          'ENTER',
                          style: Theme.of(context).textTheme.bodyText1!.merge(
                                TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: darkBlueText,
                                ),
                              ),
                        ),
                      )),
                ],
              ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int index = 0; index < 4; index++)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: Container(
                    height: 70,
                    width: 70,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int index = 0; index < pinLen; index++)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: Container(
                    height: 70,
                    width: 70,
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
                    height: 70,
                    width: 70,
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
            color: darkBlueText,
          ),
        ),
        child: TextButton(
          onPressed: () {
            context
                .read<EmployeePinBloc>()
                .add(EnterEmployeePinEvent(enteredPIN: character));
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
