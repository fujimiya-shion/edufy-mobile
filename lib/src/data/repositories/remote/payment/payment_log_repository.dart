import 'package:edufy_mobile/src/core/network/api_client.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/remote/base_repository.dart';
import 'package:edufy_mobile/src/shared/configs/app_endpoints.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

import 'i_payment_log_repository.dart';

class PaymentLogRepository extends BaseRepository
    implements IPaymentLogRepository {
  PaymentLogRepository({required ApiClient apiClient})
      : super(dio: apiClient);

  @override
  Future<ApiResult<List<PaymentLogModel>, ApiException>> getByPayment(
      int paymentId) {
    return get<List<PaymentLogModel>>(
      endpoint: AppEndpoints.paymentLogs,
      parameters: {'payment_id': paymentId},
      fromMap: (json) {
        final list = (json['data'] ?? json) as List;
        return list
            .map((e) =>
                PaymentLogModel.fromJson(e as Map<String, dynamic>))
            .toList();
      },
    );
  }
}
