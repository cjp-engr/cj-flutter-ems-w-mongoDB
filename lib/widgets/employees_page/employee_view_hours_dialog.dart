import 'package:flutter/material.dart';

class EmployeeViewHoursDialog extends StatelessWidget {
  const EmployeeViewHoursDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Text(
              'TOTAL WORK TIME',
              style: Theme.of(context).textTheme.headline5!.merge(
                    const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
            Text(
              '00:00',
              style: Theme.of(context).textTheme.headline5!.merge(
                    const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 6.5,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 6.5,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5.5,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete_outline,
                      size: 45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
