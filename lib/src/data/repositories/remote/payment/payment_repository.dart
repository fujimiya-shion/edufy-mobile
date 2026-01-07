// lib/src/data/repositories/payment/payment_repository.dart
import 'package:edufy_mobile/src/core/network/api_client.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/remote/base_repository.dart';
import 'package:edufy_mobile/src/shared/configs/app_endpoints.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

import 'i_payment_repository.dart';

class PaymentRepository extends BaseRepository implements IPaymentRepository {
  PaymentRepository({required ApiClient apiClient}) : super(dio: apiClient);

  @override
  Future<ApiResult<PaymentModel, ApiException>> createIntent({
    required int orderId,
    required String provider,
  }) {
    return post<PaymentModel>(
      endpoint: AppEndpoints.paymentsCreateIntent,
      data: {
        'order_id': orderId,
        'provider': provider,
      },
      fromMap: (json) {
        final data = (json['data'] ?? json) as Map<String, dynamic>;
        return PaymentModel.fromJson(data);
      },
    );
  }

  @override
  Future<ApiResult<PaymentModel, ApiException>> confirm({
    required String providerPaymentId,
  }) {
    return post<PaymentModel>(
      endpoint: AppEndpoints.paymentsConfirm,
      data: {'provider_payment_id': providerPaymentId},
      fromMap: (json) {
        final data = (json['data'] ?? json) as Map<String, dynamic>;
        return PaymentModel.fromJson(data);
      },
    );
  }
}
