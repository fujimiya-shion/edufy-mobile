// lib/src/data/repositories/payment/mock_payment_repository.dart
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';

import 'i_payment_repository.dart';

class MockPaymentRepository implements IPaymentRepository {
  @override
  Future<ApiResult<PaymentModel, ApiException>> createIntent({
    required int orderId,
    required String provider,
  }) async {
    await Future.delayed(const Duration(milliseconds: 250));

    final payment = PaymentModel(
      id: 1,
      orderId: orderId,
      provider: provider,
      clientSecret: 'mock_client_secret_${DateTime.now().millisecondsSinceEpoch}',
      amount: 3500000,
      currency: 'VND',
      status: 'requires_confirmation',
    );

    return ApiResult(response: payment);
  }

  @override
  Future<ApiResult<PaymentModel, ApiException>> confirm({
    required String providerPaymentId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 250));

    final payment = PaymentModel(
      id: 1,
      providerPaymentId: providerPaymentId,
      status: 'succeeded',
      paidAt: DateTime.now(),
    );

    return ApiResult(response: payment);
  }
}
