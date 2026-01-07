import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/banner/banner_model.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

abstract class IBannerRepository {
  Future<ApiResult<PaginationResponse<BannerModel>, ApiException>> getBanners();
}