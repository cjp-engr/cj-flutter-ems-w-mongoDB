import 'package:ems_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SwitchPin extends StatelessWidget {
  const SwitchPin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2.4,
              height: MediaQuery.of(context).size.height / 1.3,
              color: Colors.white,
              child: StreamBuilder(
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
                          DateFormat('E, MMM d, yyyy').format(DateTime.now()),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: darkBlueText,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.4,
              height: MediaQuery.of(context).size.height / 1.3,
              child: Column(
                children: [
                  const PinEntered(
                    pinLen: 0,
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
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: yellowButton,
                            ),
                            child: Text(
                              'IN',
                              style: TextStyle(
                                color: darkBlueText,
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          width: 130,
                          child: ElevatedButton(
                              onPressed: () {},
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
                              )),
                        ),
                        SizedBox(
                          height: 80,
                          width: 130,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: yellowButton,
                              ),
                              child: Text(
                                'OUT',
                                style: TextStyle(
                                  color: darkBlueText,
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
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
                  child: SizedBox(
                    height: 80,
                    width: 80,
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
          onPressed: () {},
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
