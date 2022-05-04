import 'package:flutter/material.dart';

class ShowInfoDialogEmployee extends StatefulWidget {
  const ShowInfoDialogEmployee({Key? key}) : super(key: key);

  @override
  State<ShowInfoDialogEmployee> createState() => _ShowInfoDialogEmployeeState();
}

class _ShowInfoDialogEmployeeState extends State<ShowInfoDialogEmployee> {
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
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _firstNameField(
                            _fieldWidth,
                            _fieldHeight,
                          ),
                          _lastNameField(
                            _fieldWidth,
                            _fieldHeight,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _emailField(
                            _fieldWidth,
                            _fieldHeight,
                          ),
                          _phoneNumberField(
                            _fieldWidth,
                            _fieldHeight,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _employeeIdField(
                            _fieldWidth,
                            _fieldHeight,
                          ),
                          _jobRoleField(
                            _fieldWidth,
                            _fieldHeight,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _payTypeField(
                            _fieldWidth,
                            _fieldHeight,
                          ),
                          _hourlyRateField(
                            _fieldWidth,
                            _fieldHeight,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _weeklyHoursField(
                            _fieldWidth,
                            _fieldHeight,
                          ),
                          _editPINbutton(
                            _fieldWidth,
                            _fieldHeight,
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

  Widget _firstNameField(final _fieldWidth, _fieldHeight) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 10,
        bottom: 10,
      ),
      child: SizedBox(
        height: _fieldHeight,
        width: _fieldWidth,
        child: TextFormField(
          keyboardType: TextInputType.name,
          autocorrect: false,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(),
            filled: true,
            labelText: 'First Name',
          ),
        ),
      ),
    );
  }

  Widget _lastNameField(final _fieldWidth, _fieldHeight) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
        top: 10,
        bottom: 10,
      ),
      child: SizedBox(
        height: _fieldHeight,
        width: _fieldWidth,
        child: TextFormField(
          keyboardType: TextInputType.name,
          autocorrect: false,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(),
            filled: true,
            labelText: 'Last Name',
          ),
        ),
      ),
    );
  }

  Widget _emailField(final _fieldWidth, _fieldHeight) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 10,
        bottom: 10,
      ),
      child: SizedBox(
        height: _fieldHeight,
        width: _fieldWidth,
        child: TextFormField(
          keyboardType: TextInputType.name,
          autocorrect: false,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(),
            filled: true,
            labelText: 'Email',
          ),
        ),
      ),
    );
  }

  Widget _phoneNumberField(final _fieldWidth, _fieldHeight) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 20,
            top: 10,
            bottom: 10,
          ),
          child: SizedBox(
            height: _fieldHeight,
            width: _fieldWidth,
            child: TextFormField(
              keyboardType: TextInputType.name,
              autocorrect: false,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: const OutlineInputBorder(),
                filled: true,
                labelText: 'Phone Number',
                prefixIcon: Container(
                  width: 90,
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Icon(
                          Icons.map,
                        ),
                        Text(
                          '+63',
                          style: Theme.of(context).textTheme.bodyText1,
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
          ),
        ),
      ],
    );
  }

  Widget _employeeIdField(final _fieldWidth, _fieldHeight) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 10,
        bottom: 10,
      ),
      child: SizedBox(
        height: _fieldHeight,
        width: _fieldWidth,
        child: TextFormField(
          keyboardType: TextInputType.name,
          autocorrect: false,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(),
            filled: true,
            labelText: 'Employee ID',
          ),
        ),
      ),
    );
  }

  Widget _jobRoleField(final _fieldWidth, _fieldHeight) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
        top: 10,
        bottom: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        height: _fieldHeight,
        width: _fieldWidth,
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            items: <String>[
              'Manager',
              'Assistant Manager',
              'Cashier',
              'Janitor',
              'Bartender'
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
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
    );
  }

  Widget _payTypeField(final _fieldWidth, _fieldHeight) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 10,
        bottom: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        height: _fieldHeight,
        width: _fieldWidth,
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            items: <String>[
              'Hourly',
              'Salary',
              'My Test',
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
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
    );
  }

  Widget _hourlyRateField(final _fieldWidth, _fieldHeight) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
        top: 10,
        bottom: 10,
      ),
      child: SizedBox(
        height: _fieldHeight,
        width: _fieldWidth,
        child: TextFormField(
          keyboardType: TextInputType.name,
          autocorrect: false,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(),
            filled: true,
            labelText: '\$0.00',
          ),
        ),
      ),
    );
  }

  Widget _weeklyHoursField(final _fieldWidth, _fieldHeight) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 10,
        bottom: 10,
      ),
      child: SizedBox(
        height: _fieldHeight,
        width: _fieldWidth,
        child: TextFormField(
          keyboardType: TextInputType.name,
          autocorrect: false,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(),
            filled: true,
            labelText: '0',
          ),
        ),
      ),
    );
  }

  Widget _editPINbutton(final _fieldWidth, _fieldHeight) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
        top: 10,
        bottom: 10,
      ),
      child: SizedBox(
        height: _fieldHeight,
        width: _fieldWidth,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('EDIT PIN'),
        ),
      ),
    );
  }
}
