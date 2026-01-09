// lib/src/data/repositories/payment/i_payment_repository.dart
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/dtos/payment/payment_dto.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';

abstract class IPaymentRepository {
  Future<ApiResult<ObjectResponse<PaymentCreateIntentResponse>, ApiException>> createIntent({
    required PaymentPayloadRequest payload,
    required String provider,
  });

  Future<ApiResult<PaymentModel, ApiException>> confirm({
    required String providerPaymentId,
  });
}
