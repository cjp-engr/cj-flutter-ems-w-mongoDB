import 'dart:developer';

import 'package:ems_app/models/country_codes.dart';
import 'package:ems_app/repositories/country_code_repository.dart';
import 'package:flutter/material.dart';

class CountryCodesDialog extends StatelessWidget {
  const CountryCodesDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
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
                  FutureBuilder(
                    future: readJsonData(),
                    builder: (context, data) {
                      if (data.hasError) {
                        return Center(child: Text("${data.error}"));
                      } else if (data.hasData) {
                        var items = data.data as List<CountryCodes>;

                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  log(items[index].name!);
                                },
                                child: Card(
                                  elevation: 0,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        child: Text(items[index].code!),
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      Text(items[index].name!),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
      autocorrect: false,
      textAlignVertical: TextAlignVertical.bottom,
      onChanged: (String? countrySearch) {
        if (countrySearch != null) {
          log(countrySearch);
        }
      },
    );
  }
}
