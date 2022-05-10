import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ems_app/blocs/blocs.dart';
import 'package:ems_app/constants/constants.dart';
import 'package:ems_app/models/employee.dart';
import 'package:ems_app/widgets/employees_page/country_codes_dialog.dart';
import 'package:ems_app/widgets/employees_page/employee_pin_dialog.dart';
import 'package:ems_app/widgets/employees_page/employee_upload_photo_dialog.dart';

class ShowInfoEmployeeDialog extends StatefulWidget {
  final Employee employeeDetails;
  const ShowInfoEmployeeDialog({
    Key? key,
    required this.employeeDetails,
  }) : super(key: key);

  @override
  State<ShowInfoEmployeeDialog> createState() => _ShowInfoEmployeeDialogState();
}

class _ShowInfoEmployeeDialogState extends State<ShowInfoEmployeeDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final _fieldWidth = MediaQuery.of(context).size.width / 1.4 / 2.2;
    const _fieldHeight = 50.0;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                      bottom: 10,
                    ),
                    child: Text(
                      'CONTACT INFORMATION',
                      style: Theme.of(context).textTheme.headline5!.merge(
                            const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _firstNameField(
                            _fieldWidth,
                            _fieldHeight,
                            widget.employeeDetails.firstName!,
                          ),
                          _lastNameField(
                            _fieldWidth,
                            _fieldHeight,
                            widget.employeeDetails.lastName!,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _emailField(
                            _fieldWidth,
                            _fieldHeight,
                            widget.employeeDetails.email!,
                          ),
                          _phoneNumberField(
                            _fieldWidth,
                            _fieldHeight,
                            widget.employeeDetails.phoneNumber!,
                            widget.employeeDetails.countryCode!,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _employeeIdField(
                            _fieldWidth,
                            _fieldHeight,
                            widget.employeeDetails.employeeId!,
                          ),
                          _jobRoleField(
                            _fieldWidth,
                            _fieldHeight,
                            widget.employeeDetails.jobRole!,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _payTypeField(
                            _fieldWidth,
                            _fieldHeight,
                            widget.employeeDetails.payType!,
                          ),
                          _hourlyRateField(
                            _fieldWidth,
                            _fieldHeight,
                            widget.employeeDetails.hourlyRate!,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _editPINbutton(
                                _fieldWidth,
                                _fieldHeight,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              _imageField(
                                _fieldWidth,
                                _fieldHeight,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              _weeklyHoursField(
                                _fieldWidth,
                                _fieldHeight,
                                widget.employeeDetails.weeklyHours!,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  _doneButton(),
                                  _cancelButton(),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstNameField(
    final fieldWidth,
    fieldHeight,
    String firstName,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FIRST NAME',
            style: Theme.of(context).textTheme.bodyText1!.merge(
                  const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
          ),
          SizedBox(
            height: fieldHeight,
            width: fieldWidth,
            child: TextFormField(
              initialValue: firstName,
              style: Theme.of(context).textTheme.bodyText1,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.name,
              autocorrect: false,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusedFieldColor,
                    width: 3,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: const OutlineInputBorder(),
                filled: true,
              ),
              cursorColor: focusedFieldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _lastNameField(
    final fieldWidth,
    fieldHeight,
    String lastName,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LAST NAME',
            style: Theme.of(context).textTheme.bodyText1!.merge(
                  const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
          ),
          SizedBox(
            height: fieldHeight,
            width: fieldWidth,
            child: TextFormField(
              initialValue: lastName,
              style: Theme.of(context).textTheme.bodyText1,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.name,
              autocorrect: false,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusedFieldColor,
                    width: 3,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: const OutlineInputBorder(),
                filled: true,
              ),
              cursorColor: focusedFieldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailField(
    final fieldWidth,
    fieldHeight,
    String email,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EMAIL',
            style: Theme.of(context).textTheme.bodyText1!.merge(
                  const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
          ),
          SizedBox(
            height: fieldHeight,
            width: fieldWidth,
            child: TextFormField(
              initialValue: email,
              style: Theme.of(context).textTheme.bodyText1,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusedFieldColor,
                    width: 3,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: const OutlineInputBorder(),
                filled: true,
              ),
              cursorColor: focusedFieldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _phoneNumberField(
    final fieldWidth,
    fieldHeight,
    String phoneNumber,
    String countryCode,
  ) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PHONE NUMBER',
                style: Theme.of(context).textTheme.bodyText1!.merge(
                      const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              ),
              SizedBox(
                height: fieldHeight,
                width: fieldWidth,
                child: TextFormField(
                  initialValue: phoneNumber,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.phone,
                  autocorrect: false,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: focusedFieldColor,
                        width: 3,
                      ),
                    ),
                    filled: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        width: 100,
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => const CountryCodesDialog(),
                            );
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                ),
                                child: BlocBuilder<CountryCodesBloc,
                                    CountryCodesState>(
                                  builder: (context, state) {
                                    return Text(
                                      countryCode,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    );
                                  },
                                ),
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  cursorColor: focusedFieldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _employeeIdField(
    final fieldWidth,
    fieldHeight,
    String employeeId,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EMPLOYEE ID',
            style: Theme.of(context).textTheme.bodyText1!.merge(
                  const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
          ),
          SizedBox(
            height: fieldHeight,
            width: fieldWidth,
            child: TextFormField(
              initialValue: employeeId,
              style: Theme.of(context).textTheme.bodyText1,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.name,
              autocorrect: false,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusedFieldColor,
                    width: 3,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: const OutlineInputBorder(),
                filled: true,
              ),
              cursorColor: focusedFieldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _jobRoleField(
    final fieldWidth,
    fieldHeight,
    String jobRole,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'JOB ROLE',
            style: Theme.of(context).textTheme.bodyText1!.merge(
                  const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
            height: fieldHeight,
            width: fieldWidth,
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                value: jobRole,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                items: <String>[
                  'Manager',
                  'Assistant Manager',
                  'Cashier',
                  'Janitor',
                  'Bartender',
                  'N/A',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (_) {},
                style: Theme.of(context).textTheme.bodyText1,
                isExpanded: true,
                menuMaxHeight: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _payTypeField(
    final fieldWidth,
    fieldHeight,
    String payType,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PAY TYPE',
            style: Theme.of(context).textTheme.bodyText1!.merge(
                  const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
            height: fieldHeight,
            width: fieldWidth,
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                value: payType,
                decoration: const InputDecoration(border: InputBorder.none),
                items: <String>[
                  'Hourly',
                  'Salary',
                  'N/A',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (_) {},
                style: Theme.of(context).textTheme.bodyText1,
                isExpanded: true,
                menuMaxHeight: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hourlyRateField(
    final fieldWidth,
    fieldHeight,
    int hourlyRate,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HOURLY RATE',
            style: Theme.of(context).textTheme.bodyText1!.merge(
                  const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
          ),
          SizedBox(
            height: fieldHeight,
            width: fieldWidth,
            child: TextFormField(
              initialValue: hourlyRate.toString(),
              style: Theme.of(context).textTheme.bodyText1,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.number,
              autocorrect: false,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusedFieldColor,
                    width: 3,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: const OutlineInputBorder(),
                filled: true,
                labelText: '\$0.00',
              ),
              cursorColor: focusedFieldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _weeklyHoursField(
    final fieldWidth,
    fieldHeight,
    int weeklyHours,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'WEEKLY HOURS',
            style: Theme.of(context).textTheme.bodyText1!.merge(
                  const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
          ),
          SizedBox(
            height: fieldHeight,
            width: fieldWidth,
            child: TextFormField(
              initialValue: weeklyHours.toString(),
              style: Theme.of(context).textTheme.bodyText1,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.number,
              autocorrect: false,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusedFieldColor,
                    width: 3,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: const OutlineInputBorder(),
                filled: true,
                labelText: '0',
              ),
              cursorColor: focusedFieldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _editPINbutton(final fieldWidth, fieldHeight) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: SizedBox(
        height: fieldHeight,
        width: fieldWidth,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const EmployeePinDialog(),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: yellowButton,
          ),
          child: Text(
            'EDIT PIN',
            style: Theme.of(context).textTheme.bodyText1!.merge(
                  TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkBlueText,
                  ),
                ),
          ),
        ),
      ),
    );
  }

  Widget _imageField(final fieldWidth, fieldHeight) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: SizedBox(
        height: fieldHeight,
        width: fieldWidth,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const EmployeeUploadPhotoDialog(),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: redButton,
          ),
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
    );
  }

  Widget _doneButton() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: SizedBox(
        height: 50,
        width: 100,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: yellowButton,
          ),
          child: Text(
            'DONE',
            style: Theme.of(context).textTheme.bodyText1!.merge(
                  TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkBlueText,
                  ),
                ),
          ),
        ),
      ),
    );
  }

  Widget _cancelButton() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10,
        left: 20,
        top: 10,
        bottom: 10,
      ),
      child: SizedBox(
        height: 50,
        width: 110,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            primary: redButton,
          ),
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
    );
  }
}
