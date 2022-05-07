import 'dart:developer';

import 'package:ems_app/constants/constants.dart';
import 'package:flutter/material.dart';

class EmployeePinDialog extends StatelessWidget {
  const EmployeePinDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 1.3,
        child: Column(
          children: [
            Row(
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
                        child:
                            Image.asset('assets/images/asterisk_unfilled.png'),
                      ),
                    ),
                  ),
              ],
            ),
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: yellowButton,
                ),
                onPressed: () {},
                child: Text(
                  'ENTER',
                  style: Theme.of(context).textTheme.bodyText1!.merge(
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          color: darkBlueText,
                        ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
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
            log(character);
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
