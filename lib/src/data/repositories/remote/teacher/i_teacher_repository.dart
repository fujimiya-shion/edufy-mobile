import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';

abstract class ITeacherRepository {
  Future<ApiResult<PaginationResponse<TeacherModel>, ApiException>> index({
    int page = 1,
    String? keyword,
  });

  Future<ApiResult<ObjectResponse<TeacherModel>, ApiException>> getDetail(int id);
}
