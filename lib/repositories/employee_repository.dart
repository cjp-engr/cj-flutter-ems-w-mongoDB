import 'package:ems_app/exceptions/custom_exception.dart';
import 'package:ems_app/models/model_custom_error.dart';
import 'package:ems_app/models/employee.dart';
import 'package:ems_app/services/employee_api_services.dart';

class EmployeeRepository {
  final EmployeeApiServices employeeApiServices;
  EmployeeRepository({
    required this.employeeApiServices,
  });

  Future<List<Employee>?> fetchEmployeesList() async {
    try {
      List<Employee>? employees = await employeeApiServices.getEmployees();
      return employees;
    } on CustomException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }
}
