import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';

import 'i_payment_log_repository.dart';

class MockPaymentLogRepository implements IPaymentLogRepository {
  const MockPaymentLogRepository();

  @override
  Future<ApiResult<List<PaymentLogModel>, ApiException>> getByPayment(
      int paymentId) async {
    await Future.delayed(const Duration(milliseconds: 150));

    final list = <PaymentLogModel>[
      PaymentLogModel(
        id: 1,
        paymentId: paymentId,
        event: 'created',
        level: 'info',
        payload: const {'message': 'Payment intent created (mock)'},
      ),
      PaymentLogModel(
        id: 2,
        paymentId: paymentId,
        event: 'succeeded',
        level: 'info',
        payload: const {'message': 'Payment succeeded (mock)'},
      ),
    ];

    return ApiResult(response: list);
  }
}
