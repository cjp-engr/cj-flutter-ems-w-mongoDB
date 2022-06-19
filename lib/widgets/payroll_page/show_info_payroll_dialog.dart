import 'package:ems_app/blocs/blocs.dart';
import 'package:ems_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PAYROLL INFORMATION',
                        style: Theme.of(context).textTheme.headline5!.merge(
                              const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      ),
                      BlocBuilder<PayrollBloc, PayrollState>(
                        builder: (context, state) {
                          if (state.payrollStatus == PayrollStatus.loading) {
                            return Container();
                          }
                          double totalSum = 0.00;
                          for (var el in state.listPayroll) {
                            totalSum += (double.tryParse(
                                    el.workedHours!.toStringAsFixed(2))! *
                                double.tryParse(
                                    el.hourlyRate!.toStringAsFixed(2))!);
                          }

                          return Text(
                            'Total: \$' + totalSum.toStringAsFixed(2),
                            style: Theme.of(context).textTheme.headline6!.merge(
                                  const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          );
                        },
                      ),
                    ],
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

  String _date(int workDate) {
    String convertedDate = DateFormat('MMMM d')
        .format(DateTime.fromMillisecondsSinceEpoch(workDate));
    return convertedDate;
  }

  String _totalPerEntry(double rate, double hoursWorked) {
    if (hoursWorked.toStringAsFixed(2) == '0.00') {
      return '0.00';
    } else {
      return (double.tryParse(rate.toStringAsFixed(2))! *
              double.tryParse(hoursWorked.toStringAsFixed(2))!)
          .toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayrollBloc, PayrollState>(
      builder: (context, state) {
        if (state.payrollStatus == PayrollStatus.loaded &&
            state.listPayroll.isEmpty) {
          return const Center(
            child: Text('Empty'),
          );
        }
        if (state.payrollStatus == PayrollStatus.loading) {
          return const Center(child: Text('Loading...'));
        }
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          padding: const EdgeInsets.all(15),
          child: Table(
            border: TableBorder.symmetric(
              inside: const BorderSide(width: 1),
            ), //table border
            children: [
              const TableRow(
                children: [
                  TableCell(
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
                    child: Text(
                      'Rate',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Text('Hours Worked',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  TableCell(
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
              for (int i = 0; i < state.listPayroll.length; i++)
                TableRow(
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Text(
                          _date(state.listPayroll[i].workDate!),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(
                        '\$' +
                            state.listPayroll[i].hourlyRate!.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(
                        state.listPayroll[i].workedHours!.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(
                        '\$' +
                            _totalPerEntry(
                              state.listPayroll[i].hourlyRate!,
                              state.listPayroll[i].workedHours!,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
