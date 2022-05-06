import 'package:flutter/material.dart';

class EmployeeViewHoursDialog extends StatelessWidget {
  const EmployeeViewHoursDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 5.5,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('start'),
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 1.0,
                            color: Colors.black,
                          ),
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          elevation: 0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 5.5,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('end'),
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 1.0,
                            color: Colors.black,
                          ),
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          elevation: 0,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 5.5,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
