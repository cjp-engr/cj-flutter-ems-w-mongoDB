import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? countryCode;
  final String? phoneNumber;
  final String? employeeId;
  final String? jobRole;
  final String? payType;
  final double? hourlyRate;
  final int? weeklyHours;
  final int? pin;
  final String? imageUrl;

  const Employee({
    this.id,
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
    this.imageUrl,
  });

  Employee.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        countryCode = json['countryCode'],
        phoneNumber = json['phoneNumber'],
        employeeId = json['employeeId'],
        jobRole = json['jobRole'],
        payType = json['payType'],
        hourlyRate =
            json['hourlyRate'] == null ? 0.0 : json['hourlyRate'].toDouble(),
        weeklyHours = json['weeklyHours'],
        pin = json['pin'],
        imageUrl = json['imageUrl'];

  factory Employee.initial() => const Employee(
        id: '',
        firstName: '',
        lastName: '',
        email: '',
        countryCode: '+63',
        phoneNumber: '',
        employeeId: '',
        jobRole: 'N/A',
        payType: 'N/A',
        hourlyRate: 0,
        weeklyHours: 0,
        pin: 0,
        imageUrl: '',
      );

  @override
  List<Object?> get props {
    return [
      id,
      firstName,
      lastName,
      email,
      countryCode,
      phoneNumber,
      employeeId,
      jobRole,
      payType,
      hourlyRate,
      weeklyHours,
      pin,
      imageUrl,
    ];
  }

  @override
  String toString() {
    return 'Employee(id: $id, firstName: $firstName, lastName: $lastName, email: $email, countryCode: $countryCode, phoneNumber: $phoneNumber, employeeId: $employeeId, jobRole: $jobRole, payType: $payType, hourlyRate: $hourlyRate, weeklyHours: $weeklyHours, imageUrl: $imageUrl)';
  }
}
