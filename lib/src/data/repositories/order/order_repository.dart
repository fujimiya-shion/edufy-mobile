import 'package:edufy_mobile/src/core/network/api_client.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/dtos/transaction/transaction_dto.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/base_repository.dart';
import 'package:edufy_mobile/src/shared/configs/app_endpoints.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

import 'i_order_repository.dart';

class OrderRepository extends BaseRepository implements IOrderRepository {
  OrderRepository({required ApiClient apiClient}) : super(dio: apiClient);

  @override
  Future<ApiResult<ObjectResponse<OrderModel>, ApiException>> checkout({
    required OrderCheckoutRequest request,
  }) {
    return post(
      endpoint: AppEndpoints.ordersCheckout,
      data: {
        'cart_id': request.cartId,
        if (request.paymentMethod != null) 'payment_method': request.paymentMethod,
        if (request.note != null) 'note': request.note,
      },
      fromMap: (json) =>
          ObjectResponse<OrderModel>.fromJson(json, OrderModel.fromJson),
    );
  }

  @override
  Future<ApiResult<PaginationResponse<OrderModel>, ApiException>> index({
    int page = 1,
  }) {
    return get(
      endpoint: AppEndpoints.ordersMy,
      parameters: {'page': page},
      fromMap: (json) =>
          PaginationResponse<OrderModel>.fromJson(json, OrderModel.fromJson),
    );
  }

  @override
  Future<ApiResult<ObjectResponse<OrderModel>, ApiException>> getDetail(
    int id,
  ) {
    return get(
      endpoint: '${AppEndpoints.orders}/$id',
      fromMap: (json) =>
          ObjectResponse<OrderModel>.fromJson(json, OrderModel.fromJson),
    );
  }

  @override
  Future<ApiResult<ObjectResponse<OrderModel>, ApiException>> cancel(int id) {
    return post(
      endpoint: AppEndpoints.orderCancel(id),
      fromMap: (json) =>
          ObjectResponse<OrderModel>.fromJson(json, OrderModel.fromJson),
    );
  }
}
