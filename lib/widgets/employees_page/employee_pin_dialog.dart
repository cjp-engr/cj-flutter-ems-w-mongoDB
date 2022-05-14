import 'package:ems_app/blocs/employee_pin/employee_pin_bloc.dart';
import 'package:ems_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeePinDialog extends StatelessWidget {
  const EmployeePinDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 1.3,
          child: BlocBuilder<EmployeePinBloc, EmployeePinState>(
            builder: (context, state) {
              return Column(
                children: [
                  state.pinLength == 0
                      ? const NoPinEntered()
                      : state.pinLength == 1
                          ? const OnePinEntered()
                          : state.pinLength == 2
                              ? const TwoPinEntered()
                              : state.pinLength == 3
                                  ? const ThreePinEntered()
                                  : state.pinLength == 4
                                      ? const FourPinEntered()
                                      : const FourPinEntered(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Please enter your 4-digit PIN code',
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
                    child: BlocBuilder<EmployeePinBloc, EmployeePinState>(
                      builder: (context, state) {
                        return ElevatedButton(
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
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class NoPinEntered extends StatelessWidget {
  const NoPinEntered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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

class OnePinEntered extends StatelessWidget {
  const OnePinEntered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int index = 0; index < 1; index++)
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
        for (int index = 1; index < 4; index++)
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

class TwoPinEntered extends StatelessWidget {
  const TwoPinEntered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int index = 0; index < 2; index++)
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
        for (int index = 2; index < 4; index++)
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

class ThreePinEntered extends StatelessWidget {
  const ThreePinEntered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int index = 0; index < 3; index++)
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
        for (int index = 3; index < 4; index++)
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

class FourPinEntered extends StatelessWidget {
  const FourPinEntered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
                child: Image.asset('assets/images/asterisk_filled.png'),
              ),
            ),
          ),
      ],
    );
  }
}
