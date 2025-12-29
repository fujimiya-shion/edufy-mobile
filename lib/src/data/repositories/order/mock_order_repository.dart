import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/dtos/transaction/transaction_dto.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';

import 'i_order_repository.dart';

class MockOrderRepository implements IOrderRepository {
  final List<OrderModel> _orders = [];

  @override
  Future<ApiResult<ObjectResponse<OrderModel>, ApiException>> checkout({
    required OrderCheckoutRequest request,
  }) async {
    await Future.delayed(const Duration(milliseconds: 250));

    final order = OrderModel(
      id: _orders.length + 1,
      orderNumber: 'EDU-${DateTime.now().millisecondsSinceEpoch}',
      status: 'pending',
      paymentStatus: 'unpaid',
      cartId: request.cartId,
      total: 3500000,
      subtotal: 3500000,
      note: request.note,
    );

    _orders.add(order);

    return ApiResult(
      response: ObjectResponse<OrderModel>(data: order),
    );
  }

  @override
  Future<ApiResult<PaginationResponse<OrderModel>, ApiException>> index({
    int page = 1,
  }) async {
    await Future.delayed(const Duration(milliseconds: 180));

    const pageSize = 10;
    final start = (page - 1) * pageSize;
    final end = (start + pageSize) > _orders.length
        ? _orders.length
        : (start + pageSize);

    final paged = start >= _orders.length
        ? <OrderModel>[]
        : _orders.sublist(start, end);

    final pagination = PaginationResponse<OrderModel>(
      data: paged,
      total: _orders.length,
      page: page,
      perPage: pageSize,
      pageCount: (_orders.length / pageSize).ceil(),
    );

    return ApiResult(response: pagination);
  }

  @override
  Future<ApiResult<ObjectResponse<OrderModel>, ApiException>> getDetail(
      int id) async {
    await Future.delayed(const Duration(milliseconds: 120));

    final order = _orders.firstWhere(
      (o) => o.id == id,
      orElse: () => _orders.last,
    );

    return ApiResult(
      response: ObjectResponse<OrderModel>(data: order),
    );
  }

  @override
  Future<ApiResult<ObjectResponse<OrderModel>, ApiException>> cancel(
      int id) async {
    await Future.delayed(const Duration(milliseconds: 150));

    final index = _orders.indexWhere((o) => o.id == id);
    if (index == -1) {
      return ApiResult(
        exception: ApiException(
          message: 'Order not found',
          httpStatus: 404,
        ),
      );
    }

    final updated = _orders[index].copyWith(
      status: 'cancelled',
      paymentStatus: 'cancelled',
    );

    _orders[index] = updated;

    return ApiResult(
      response: ObjectResponse<OrderModel>(data: updated),
    );
  }
}
