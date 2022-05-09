class Employee {
  // final String? code;
  // final String? name;
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? countryCode;
  final String? phoneNumber;
  final String? employeeId;
  final String? jobRole;
  final String? payType;
  final int? hourlyRate;
  final int? weeklyHours;
  final int? pin;

  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.countryCode,
    required this.phoneNumber,
    required this.employeeId,
    required this.jobRole,
    required this.payType,
    required this.hourlyRate,
    required this.weeklyHours,
    required this.pin,
  });

  Employee.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        countryCode = json['countryCode'],
        phoneNumber = json['phoneNumber'],
        employeeId = json['employeeId'],
        jobRole = json['jobRole'],
        payType = json['payType'],
        hourlyRate = json['hourlyRate'],
        weeklyHours = json['weeklyHours'],
        pin = json['pin'];
}
