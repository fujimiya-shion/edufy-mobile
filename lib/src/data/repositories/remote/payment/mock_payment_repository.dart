// lib/src/data/repositories/payment/mock_payment_repository.dart
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/dtos/payment/payment_dto.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';

import 'i_payment_repository.dart';

class MockPaymentRepository implements IPaymentRepository {
  @override
  Future<ApiResult<ObjectResponse<PaymentCreateIntentResponse>, ApiException>> createIntent({
    required PaymentPayloadRequest payload,
    required String provider,
  }) async {
    await Future.delayed(const Duration(milliseconds: 250));

    final response = ObjectResponse<PaymentCreateIntentResponse>(
      data: PaymentCreateIntentResponse(
        clientSecret: "123456",
        customerId: "3434235",
        ephemeralKey: "346346346",
      )
    );

    return ApiResult(response: response);
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
