import '../../exceptions/custom_exception.dart';
import '../../models/model_custom_error.dart';
import '../../models/attendance.dart';
import '../../services/attendance_api_services.dart';

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

  Future<void> updateAttendance(
    Attendance a,
    String id,
  ) async {
    try {
      await attendanceApiServices.updateAttendance(a, id);
    } on CustomException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }

  Future<void> deleteAttendance(
    String id,
  ) async {
    try {
      await attendanceApiServices.deleteAttendance(id);
    } on CustomException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }
}
