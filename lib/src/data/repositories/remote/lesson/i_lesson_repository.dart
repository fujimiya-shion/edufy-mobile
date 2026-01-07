import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';

abstract class ILessonRepository {
  Future<ApiResult<PaginationResponse<LessonModel>, ApiException>> index({
    int page = 1,
    int? courseId,
  });

  Future<ApiResult<ObjectResponse<LessonModel>, ApiException>> getDetail(int id);
}
