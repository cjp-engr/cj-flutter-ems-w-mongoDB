class CountryCodes {
  final String? code;
  final String? name;
  CountryCodes({
    required this.code,
    required this.name,
  });

  CountryCodes.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        name = json['name'];
}
