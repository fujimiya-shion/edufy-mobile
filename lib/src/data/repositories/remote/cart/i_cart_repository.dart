// lib/src/data/repositories/cart/i_cart_repository.dart
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';

abstract class ICartRepository {
  Future<ApiResult<ObjectResponse<CartModel>, ApiException>> getMyCart();

  Future<ApiResult<ObjectResponse<CartModel>, ApiException>> addItem({
    required int courseId,
    int quantity = 1,
  });

  Future<ApiResult<ObjectResponse<CartModel>, ApiException>> removeItem(
    int cartItemId,
  );

  Future<ApiResult<ObjectResponse, ApiException>> clear();
}
