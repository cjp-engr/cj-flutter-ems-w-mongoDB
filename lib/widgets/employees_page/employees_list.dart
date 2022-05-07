import 'package:ems_app/widgets/employees_page/employee_view_hours_dialog.dart';
import 'package:ems_app/widgets/employees_page/show_info_employee_dialog.dart';
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
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 60,
                        right: 40,
                      ),
                      child: Text('EMPLOYEE'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 20,
                        left: 70,
                      ),
                      child: Text('CONTACT INFORMATION'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        // right: 20,
                        left: 240,
                      ),
                      child: Text('SCHEDULE'),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(
                    //     right: 20,
                    //     left: 185,
                    //   ),
                    //   child: Text('STATUS'),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 30,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.6,
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                itemCount: 20,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ShowInfoEmployeeDialog(),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Row(
                            children: [
                              ClipOval(
                                child: SizedBox.fromSize(
                                  size:
                                      const Size.fromRadius(27), // Image radius
                                  child: Image.asset(
                                    'assets/images/flutter_logo.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Carmen Joy Palsario',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Text(
                                    'Software Engineer',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Column(
                            children: const [
                              Text('carmen.palsario@eigital.com'),
                              Text('+63 916-275-6844'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                            left: 20,
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  const Text('CLOCK IN'),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 115,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('CLOCK OUT'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: [
                                  const Text('CLOCK OUT'),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 115,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('CLOCK IN'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: const [
                                          Text('Break Time'),
                                          Text('00H 00M'),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: const [
                                          Text('Time Worked'),
                                          Text('00H 00M'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const EmployeeViewHoursDialog(),
                                        );
                                      },
                                      child: const Text('VIEW HOURS'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // const Padding(
                        //   padding: EdgeInsets.only(
                        //     right: 25,
                        //     left: 25,
                        //   ),
                        //   child: Text('ACTIVE'),
                        // ),
                      ],
                    ),
                  ),
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
