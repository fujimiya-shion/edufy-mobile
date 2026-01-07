// lib/src/data/repositories/cart/cart_repository.dart
import 'package:edufy_mobile/src/core/network/api_client.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/remote/base_repository.dart';
import 'package:edufy_mobile/src/shared/configs/app_endpoints.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

import 'i_cart_repository.dart';

class CartRepository extends BaseRepository implements ICartRepository {
  CartRepository({required ApiClient apiClient}) : super(dio: apiClient);

  @override
  Future<ApiResult<ObjectResponse<CartModel>, ApiException>> getMyCart() {
    return get(
      endpoint: AppEndpoints.carts,
      fromMap: (json) =>
          ObjectResponse<CartModel>.fromJson(json, CartModel.fromJson),
    );
  }

  @override
  Future<ApiResult<ObjectResponse<CartModel>, ApiException>> addItem({
    required int courseId,
    int quantity = 1,
  }) {
    return post(
      endpoint: AppEndpoints.cartAddItem,
      data: {
        'course_id': courseId,
        'quantity': quantity,
      },
      fromMap: (json) =>
          ObjectResponse<CartModel>.fromJson(json, CartModel.fromJson),
    );
  }

  @override
  Future<ApiResult<ObjectResponse<CartModel>, ApiException>> removeItem(
    int cartItemId,
  ) {
    return delete(
      endpoint: AppEndpoints.cartRemoveItem(cartItemId),
      fromMap: (json) =>
          ObjectResponse<CartModel>.fromJson(json, CartModel.fromJson),
    );
  }

  @override
  Future<ApiResult<ObjectResponse, ApiException>> clear() {
    return delete(
      endpoint: AppEndpoints.cartClear,
      fromMap: ObjectResponse.fromJson,
    );
  }
}
