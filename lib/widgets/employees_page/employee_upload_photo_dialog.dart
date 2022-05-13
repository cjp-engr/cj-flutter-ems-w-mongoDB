import 'package:ems_app/constants/constants.dart';
import 'package:flutter/material.dart';

class EmployeeUploadPhotoDialog extends StatelessWidget {
  const EmployeeUploadPhotoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 1.3,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Text(
                  'UPLOAD PHOTO',
                  style: Theme.of(context).textTheme.headline5!.merge(
                        const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    Container(
                      height: 300,
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: SizedBox(
                        height: 300,
                        width: 350,
                        child: Image.asset('assets/images/camera_icon.png'),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                        height: 70,
                        width: 350,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: yellowButton,
                          ),
                          onPressed: () {},
                          child: Text(
                            'UPLOAD PHOTO',
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
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                    width: 177,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: yellowButton,
                      ),
                      onPressed: () {},
                      child: Text(
                        'CHOOSE PHOTO',
                        style: Theme.of(context).textTheme.bodyText1!.merge(
                              TextStyle(
                                fontWeight: FontWeight.bold,
                                color: darkBlueText,
                              ),
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 70,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: redButton,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'CANCEL',
                        style: Theme.of(context).textTheme.bodyText1!.merge(
                              TextStyle(
                                fontWeight: FontWeight.bold,
                                color: darkBlueText,
                              ),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
