import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';

abstract class IRibbonRepository {
  /// Ruy băng cho homepage (hero/section)
  Future<ApiResult<PaginationResponse<RibbonModel>, ApiException>> getHomeRibbons();
}
