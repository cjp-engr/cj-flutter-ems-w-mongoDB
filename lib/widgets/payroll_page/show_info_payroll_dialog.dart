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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 30,
                  ),
                  child: SizedBox(
                    height: 70,
                    width: 110,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: yellowButton,
                      ),
                      child: Text(
                        'CLOSE',
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: ListView(
                children: const [
                  PayrollInfoContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PayrollInfoContent extends StatelessWidget {
  const PayrollInfoContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(15),
      child: Table(
        //border: TableBorder.all(width: 1, color: Colors.black45),
        border: TableBorder.symmetric(
          inside: const BorderSide(width: 1),
        ), //table border
        children: [
          TableRow(
            children: [
              const TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Text(
                  'Date',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Column(
                  children: const [
                    Text('Time in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    Text('Time out',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              const TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Text('Rate',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Text('Hours Worked',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Text(
                  'Total',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          for (int i = 0; i < 100; i++)
            const TableRow(
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    'date data',
                    textAlign: TextAlign.center,
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    'time in and time out data',
                    textAlign: TextAlign.center,
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    'rate data',
                    textAlign: TextAlign.center,
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    'hours worked data',
                    textAlign: TextAlign.center,
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    'total data',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
