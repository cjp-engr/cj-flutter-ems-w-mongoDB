import '../../constants/constants.dart';
import 'package:flutter/material.dart';

class ClockinConfirmationDialog extends StatelessWidget {
  const ClockinConfirmationDialog({Key? key}) : super(key: key);

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
          children: [
            const Text(
              'Are you sure you want to clock in?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 80,
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () {},
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
                    onPressed: () {},
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
        ),
      ),
    );
  }
}
