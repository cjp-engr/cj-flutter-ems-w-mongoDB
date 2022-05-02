import 'package:flutter/material.dart';

class EmployeesList extends StatelessWidget {
  const EmployeesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 20,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[400],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  right: 20,
                  left: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('EMPLOYEE'),
                    Text('CONTACT INFORMATION'),
                    Text('SCHEDULE'),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text('STATUS'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(),
        ],
      ),
    );
  }
}
