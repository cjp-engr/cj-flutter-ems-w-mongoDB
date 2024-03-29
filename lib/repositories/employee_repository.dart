import '../../exceptions/custom_exception.dart';
import '../../models/model_custom_error.dart';
import '../../models/employee.dart';
import '../../services/employee_api_services.dart';

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

  Future<Employee?> fetchEmployeeById(String id) async {
    try {
      Employee? employee = await employeeApiServices.getEmployee(id);
      return employee;
    } on CustomException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }

  Future<void> addNewEmployee(Employee e) async {
    try {
      await employeeApiServices.addEmployee(e);
    } on CustomException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }

  Future<void> updateEmployeeDiffPin(
    Employee e,
    String id,
  ) async {
    try {
      await employeeApiServices.updateEmployeeDiffPin(e, id);
    } on CustomException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }

  Future<void> updateEmployeeSamePin(
    Employee e,
    String id,
  ) async {
    try {
      await employeeApiServices.updateEmployeeSamePin(e, id);
    } on CustomException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }

  Future<void> deleteEmployee(
    String id,
  ) async {
    try {
      await employeeApiServices.deleteEmployee(id);
    } on CustomException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }

  Future<Employee?> fetchEmployeePin(String pin) async {
    try {
      return await employeeApiServices.getEmployeePin(pin);
    } on CustomException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }
}
