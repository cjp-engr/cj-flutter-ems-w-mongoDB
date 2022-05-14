import 'package:ems_app/blocs/blocs.dart';
import 'package:ems_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryCodesDialog extends StatelessWidget {
  const CountryCodesDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countryCodesList =
        context.watch<CountryCodesBloc>().state.countryCodesList;

    return SimpleDialog(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 2.7,
              height: MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Column(
                  children: [
                    Text(
                      'Select your phone code',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SearchCountryCode(),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: ListView.builder(
                        itemCount: countryCodesList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.read<CountryCodesBloc>().add(
                                  SelectCountryCodeEvent(
                                      selectedCountryCode:
                                          countryCodesList[index].code!));
                              Navigator.pop(context);
                            },
                            child: Card(
                              elevation: 0,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 70,
                                    child: Text(countryCodesList[index].code!),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Text(countryCodesList[index].name!),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SearchCountryCode extends StatefulWidget {
  const SearchCountryCode({Key? key}) : super(key: key);

  @override
  State<SearchCountryCode> createState() => _SearchCountryCodeState();
}

class _SearchCountryCodeState extends State<SearchCountryCode> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        labelText: 'Search...',
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: focusedFieldColor,
            width: 3,
          ),
        ),
      ),
      autocorrect: false,
      textAlignVertical: TextAlignVertical.bottom,
      cursorColor: focusedFieldColor,
      onChanged: (String? searchCountrycode) {
        if (searchCountrycode != '') {
          context
              .read<CountryCodesBloc>()
              .add(FilterCountriesEvent(enteredKeyword: searchCountrycode!));
        } else {
          context.read<CountryCodesBloc>().add(FetchAllCountryCodesEvent());
        }
      },
    );
  }
}
