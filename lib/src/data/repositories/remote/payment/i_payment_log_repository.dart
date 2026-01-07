import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';

abstract class IPaymentLogRepository {
  Future<ApiResult<List<PaymentLogModel>, ApiException>> getByPayment(
    int paymentId,
  );
}
