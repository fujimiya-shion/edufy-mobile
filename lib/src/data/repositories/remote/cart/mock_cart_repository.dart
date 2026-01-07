// lib/src/data/repositories/cart/mock_cart_repository.dart
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

import 'i_cart_repository.dart';

class MockCartRepository implements ICartRepository {
  CartModel _cart = const CartModel(
    id: 1,
    status: 'active',
    subtotal: 0,
    discountTotal: 0,
    total: 0,
    items: [],
  );

  @override
  Future<ApiResult<ObjectResponse<CartModel>, ApiException>> getMyCart() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return ApiResult(
      response: ObjectResponse<CartModel>(data: _cart),
    );
  }

  @override
  Future<ApiResult<ObjectResponse<CartModel>, ApiException>> addItem({
    required int courseId,
    int quantity = 1,
  }) async {
    await Future.delayed(const Duration(milliseconds: 150));

    final price = 3500000.0;
    final newItem = CartItemModel(
      id: DateTime.now().millisecondsSinceEpoch,
      cartId: _cart.id,
      courseId: courseId,
      quantity: quantity,
      unitPrice: price,
      lineTotal: price * quantity,
    );

    final currentItems = [...?_cart.items, newItem];

    final subtotal =
        currentItems.fold<double>(0, (v, e) => v + (e.lineTotal ?? 0));

    _cart = _cart.copyWith(
      items: currentItems,
      subtotal: subtotal,
      total: subtotal - (_cart.discountTotal ?? 0),
    );

    return ApiResult(
      response: ObjectResponse<CartModel>(data: _cart),
    );
  }

  @override
  Future<ApiResult<ObjectResponse<CartModel>, ApiException>> removeItem(
    int cartItemId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 120));

    final currentItems = [...?_cart.items]
      ..removeWhere((e) => e.id == cartItemId);

    final subtotal =
        currentItems.fold<double>(0, (v, e) => v + (e.lineTotal ?? 0));

    _cart = _cart.copyWith(
      items: currentItems,
      subtotal: subtotal,
      total: subtotal - (_cart.discountTotal ?? 0),
    );

    return ApiResult(
      response: ObjectResponse<CartModel>(data: _cart),
    );
  }

  @override
  Future<ApiResult<ObjectResponse<void>, ApiException>> clear() async {
    await Future.delayed(const Duration(milliseconds: 100));

    _cart = _cart.copyWith(
      items: const [],
      subtotal: 0,
      total: 0,
    );

    return ApiResult(
      response: ObjectResponse<void>(data: null),
    );
  }
}
