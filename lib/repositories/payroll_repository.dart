import '../../models/payroll.dart';
import '../../services/payroll_api_services.dart';

import '../../exceptions/custom_exception.dart';
import '../../models/model_custom_error.dart';

class PayrollRepository {
  final PayrollApiServices payrollApiServices;
  PayrollRepository({
    required this.payrollApiServices,
  });

  Future<List<Payroll>?> fetchPayrollList(
    String uniqueId,
    String lteDate,
    String gteDate,
  ) async {
    try {
      List<Payroll>? payroll = await payrollApiServices.getPayroll(
        uniqueId,
        lteDate,
        gteDate,
      );
      return payroll;
    } on CustomException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }
}
