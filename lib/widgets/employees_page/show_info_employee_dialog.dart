import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../constants/constants.dart';
import '../../models/employee.dart';
import '../../widgets/employees_page/country_codes_dialog.dart';
import '../../widgets/employees_page/employee_pin_dialog.dart';
import '../../widgets/employees_page/employee_upload_photo_dialog.dart';

class ShowInfoEmployeeDialog extends StatelessWidget {
  const ShowInfoEmployeeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      reverse: true,
      children: [
        GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: AlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 65,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Text(
                          'EMPLOYEE INFORMATION',
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
                    height: MediaQuery.of(context).size.height / 1.25,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const ShowEmployeeForm(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ShowEmployeeForm extends StatefulWidget {
  const ShowEmployeeForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowEmployeeForm> createState() => _ShowEmployeeFormState();
}

class _ShowEmployeeFormState extends State<ShowEmployeeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  String? _firstName,
      _lastName,
      _email,
      _phoneNumber,
      _employeeId,
      _jobRole,
      _payType;

  double? _hourlyRate;
  int? _weeklyHrs;

  _employeeDetails() {
    return BlocProvider.of<EmployeeDetailsBloc>(context).state;
  }

  _countryCode() {
    final addCountryCode =
        BlocProvider.of<CountryCodesBloc>(context).state.selectedCountryCode;

    if (employeeDetails.employeeStatus == EmployeeStatus.adding) {
      return addCountryCode;
    } else if (employeeDetails.employeeStatus == EmployeeStatus.read &&
        addCountryCode != employeeDetails.employeeDetails.countryCode) {
      return addCountryCode;
    } else if (employeeDetails.employeeStatus == EmployeeStatus.read) {
      return employeeDetails.employeeDetails.countryCode;
    }
  }

  _pin() {
    final addPin = BlocProvider.of<EmployeePinBloc>(context).state.enteredPIN;
    if (employeeDetails.employeeStatus == EmployeeStatus.adding) {
      return addPin;
    } else if (employeeDetails.employeeStatus == EmployeeStatus.read &&
        addPin == 0) {
      return employeeDetails.employeeDetails.pin;
    } else if (employeeDetails.employeeStatus == EmployeeStatus.read &&
        addPin != employeeDetails.employeeDetails.pin &&
        addPin != 0) {
      return addPin;
    } else if (employeeDetails.employeeStatus == EmployeeStatus.read) {
      return employeeDetails.employeeDetails.pin;
    }
  }

  _imagePath() {
    return BlocProvider.of<EmployeeImageBloc>(context).state.imageLocalPath;
  }

  get countryCode => _countryCode();
  get pin => _pin();
  get employeeDetails => _employeeDetails();
  get imagePath => _imagePath();

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    late String? imageUrl;
    late CloudinaryResponse response;
    if (imagePath!.isNotEmpty) {
      response = await cloudinary.uploadResource(CloudinaryUploadResource(
        filePath: imagePath,
        resourceType: CloudinaryResourceType.image,
        folder: 'employees',
        fileName: _firstName! + _lastName!,
      ));
    }

    if (employeeDetails.employeeStatus == EmployeeStatus.adding) {
      if (imagePath.isNotEmpty) {
        imageUrl = response.secureUrl!;
      } else {
        imageUrl = '';
      }
    } else if (employeeDetails.employeeStatus == EmployeeStatus.read &&
        imagePath.isEmpty) {
      imageUrl = employeeDetails.employeeDetails.imageUrl!;
    } else if (employeeDetails.employeeStatus == EmployeeStatus.read &&
        response.secureUrl != employeeDetails.employeeDetails.imageUrl) {
      imageUrl = response.secureUrl;
    } else if (employeeDetails.employeeStatus == EmployeeStatus.read) {
      imageUrl = employeeDetails.employeeDetails.imageUrl!;
    }

    final emp = Employee(
      firstName: _firstName,
      lastName: _lastName,
      email: _email,
      countryCode: countryCode,
      phoneNumber: _phoneNumber,
      employeeId: _employeeId,
      jobRole: _jobRole,
      payType: _payType,
      hourlyRate: _hourlyRate,
      weeklyHours: _weeklyHrs,
      pin: pin,
      imageUrl: imageUrl,
    );

    context
        .read<EmployeeDetailsBloc>()
        .add(SubmitEmployeeDetailsEvent(emp: emp));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final _fieldWidth = MediaQuery.of(context).size.width / 1.4 / 2.2;
    const _fieldHeight = 50.0;

    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: BlocBuilder<EmployeeDetailsBloc, EmployeeDetailsState>(
        builder: (context, state) {
          if (state.employeeStatus == EmployeeStatus.reading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.employeeStatus == EmployeeStatus.read ||
              state.employeeStatus == EmployeeStatus.adding) {
            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _firstNameField(
                      _fieldWidth,
                      _fieldHeight,
                      state.employeeDetails.firstName!,
                    ),
                    _lastNameField(
                      _fieldWidth,
                      _fieldHeight,
                      state.employeeDetails.lastName!,
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
                      state.employeeDetails.email!,
                    ),
                    _phoneNumberField(
                      _fieldWidth,
                      _fieldHeight,
                      state.employeeDetails.phoneNumber!,
                      state.employeeDetails.countryCode!,
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
                      state.employeeDetails.employeeId!,
                    ),
                    _jobRoleField(
                      _fieldWidth,
                      _fieldHeight,
                      state.employeeDetails.jobRole!,
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
                      state.employeeDetails.payType!,
                    ),
                    _hourlyRateField(
                      _fieldWidth,
                      _fieldHeight,
                      state.employeeDetails.hourlyRate!,
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
                          state.employeeDetails.weeklyHours!,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            state.employeeStatus == EmployeeStatus.adding
                                ? _doneButton('ADD')
                                : _doneButton('UPDATE'),
                            _cancelButton(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                state.employeeStatus == EmployeeStatus.read
                    ? Column(
                        children: [
                          _deleteButton(state.employeeDetails.id!),
                        ],
                      )
                    : Column(),
              ],
            );
          }
          return const Center(
            child: Text('nothing to show'),
          );
        },
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
              onSaved: (String? fn) {
                _firstName = fn;
              },
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
              onSaved: (String? ln) {
                _lastName = ln;
              },
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
              onSaved: (String? e) {
                _email = e;
              },
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
                                      state.selectedCountryCode,
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
                  onSaved: (String? pn) {
                    _phoneNumber = pn;
                  },
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
              onSaved: (String? eId) {
                _employeeId = eId;
              },
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
                  'N/A',
                  'Manager',
                  'Assistant Manager',
                  'Cashier',
                  'Janitor',
                  'Bartender',
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
                onSaved: (String? jr) {
                  _jobRole = jr;
                },
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
                  'N/A',
                  'Hourly',
                  'Weekly',
                  'Salary',
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
                onSaved: (String? pt) {
                  _payType = pt;
                },
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
    double hourlyRate,
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
              onSaved: (String? hr) {
                // _hourlyRate = int.tryParse(hr!);
                _hourlyRate = double.tryParse(hr!);
              },
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
              onSaved: (String? wh) {
                _weeklyHrs = int.tryParse(wh!);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _editPINbutton(
    final fieldWidth,
    fieldHeight,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: SizedBox(
        height: fieldHeight,
        width: fieldWidth,
        child: ElevatedButton(
          onPressed: () {
            context.read<EmployeePinBloc>().add(SetInitialPinEvent());
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

  Widget _imageField(
    final fieldWidth,
    fieldHeight,
  ) {
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

  Widget _doneButton(String buttonLabel) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: SizedBox(
        height: 50,
        width: 110,
        child: ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            primary: yellowButton,
          ),
          child: Text(
            buttonLabel,
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
            context.read<EmployeeDetailsBloc>().add(
                  const FetchIdEvent(
                    id: "",
                  ),
                );
            Navigator.of(context).pop();
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

  Widget _deleteButton(String id) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10,
        left: 20,
        top: 10,
        bottom: 10,
      ),
      child: SizedBox(
        height: 50,
        width: 150,
        child: ElevatedButton(
          onPressed: () {
            context.read<EmployeeDetailsBloc>().add(DeleteEmployeeEvent(
                  id: id,
                  empStatus: EmployeeStatus.deleting,
                ));
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            primary: redButton,
          ),
          child: Text(
            'DELETE',
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
