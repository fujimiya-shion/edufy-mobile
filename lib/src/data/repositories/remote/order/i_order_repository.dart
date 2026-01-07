import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/dtos/transaction/transaction_dto.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';

abstract class IOrderRepository {
  Future<ApiResult<ObjectResponse<OrderModel>, ApiException>> checkout({
    required OrderCheckoutRequest request,
  });

  Future<ApiResult<PaginationResponse<OrderModel>, ApiException>> index({
    int page = 1,
  });

  Future<ApiResult<ObjectResponse<OrderModel>, ApiException>> getDetail(int id);
  Future<ApiResult<ObjectResponse<OrderModel>, ApiException>> cancel(int id);
}
