import 'package:flutter/material.dart';

class ShowInfoDialogEmployee extends StatefulWidget {
  const ShowInfoDialogEmployee({Key? key}) : super(key: key);

  @override
  State<ShowInfoDialogEmployee> createState() => _ShowInfoDialogEmployeeState();
}

class _ShowInfoDialogEmployeeState extends State<ShowInfoDialogEmployee> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: MediaQuery.of(context).size.height / 1.3,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('DONE'),
                ),
              ],
            ),
            // Header
            const Text('CONTACT INFORMATION'),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: ListView(
                children: [
                  Row(),
                ],
              ),
            ),
            //Field
          ],
        ),
      ),
    );
  }
}
