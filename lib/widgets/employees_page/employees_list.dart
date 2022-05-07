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
                    SizedBox(
                      width: 70,
                    ),
                    Text('EMPLOYEE'),
                    SizedBox(
                      width: 155,
                    ),
                    Text('CONTACT INFORMATION'),
                    SizedBox(
                      width: 190,
                    ),
                    Text('SCHEDULE'),
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
                          width: MediaQuery.of(context).size.width / 4.5,
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
                                width: 10,
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
                          width: MediaQuery.of(context).size.width / 4.5,
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
                          child: Column(
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
                                height: 10,
                              ),
                              SizedBox(
                                width: 250,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xffff304f),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          const EmployeeViewHoursDialog(),
                                    );
                                  },
                                  child: Text(
                                    'VIEW HOURS',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .merge(
                                          const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff002651),
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
