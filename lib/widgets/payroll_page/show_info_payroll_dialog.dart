import 'package:ems_app/constants/constants.dart';
import 'package:flutter/material.dart';

class ShowInfoPayrollDialog extends StatelessWidget {
  const ShowInfoPayrollDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Text(
                    'PAYROLL INFORMATION',
                    style: Theme.of(context).textTheme.headline5!.merge(
                          const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: SizedBox(
                height: 50,
                width: 110,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: yellowButton,
                  ),
                  child: Text(
                    'OK',
                    style: Theme.of(context).textTheme.bodyText1!.merge(
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            color: darkBlueText,
                          ),
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
