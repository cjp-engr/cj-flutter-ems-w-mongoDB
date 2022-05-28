import 'package:ems_app/exceptions/custom_exception.dart';
import 'package:ems_app/models/model_custom_error.dart';
import 'package:ems_app/models/attendance.dart';
import 'package:ems_app/services/attendance_api_services.dart';

class AttendanceRepository {
  final AttendanceApiServices attendanceApiServices;
  AttendanceRepository({
    required this.attendanceApiServices,
  });
  Future<void> addAttendance(Attendance a) async {
    try {
      await attendanceApiServices.addAttendance(a);
    } on CustomException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }

  Future<List<Attendance>?> fetchAttendanceList(
    String uniqueId,
    String workDate,
  ) async {
    try {
      List<Attendance>? attendance = await attendanceApiServices.getAttendance(
        uniqueId,
        workDate,
      );
      return attendance;
    } on CustomException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }
}
