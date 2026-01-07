// lib/src/data/repositories/banner/banner_repository.dart
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/pagination_response.dart';
import 'package:edufy_mobile/src/data/models/banner/banner_model.dart';
import 'package:edufy_mobile/src/data/repositories/remote/banner/i_banner_repository.dart';
import 'package:edufy_mobile/src/data/repositories/remote/base_repository.dart';
import 'package:edufy_mobile/src/shared/configs/app_endpoints.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

class BannerRepository extends BaseRepository implements IBannerRepository {
  BannerRepository({required super.dio});

  @override
  Future<ApiResult<PaginationResponse<BannerModel>, ApiException>> getBanners() {
    return get(
      endpoint: AppEndpoints.banners,
      fromMap: (json) => PaginationResponse<BannerModel>.fromJson(json, BannerModel.fromJson),
    );
  }
}
