import 'dart:convert';

import 'package:ems_app/models/country_codes.dart';
import 'package:flutter/services.dart' as root_bundle;

Future<List<CountryCodes>> readJsonData() async {
  try {
    final jsondata = await root_bundle.rootBundle
        .loadString('assets/jsonfiles/country_code.json');

    final codeList = json.decode(jsondata)['countries'];

    List<CountryCodes> results =
        (codeList as List).map((e) => CountryCodes.fromJson(e)).toList();
    return results;
  } catch (e) {
    rethrow;
  }
}
