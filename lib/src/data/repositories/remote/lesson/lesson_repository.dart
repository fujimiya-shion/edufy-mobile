import 'package:edufy_mobile/src/core/network/api_client.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/remote/base_repository.dart';
import 'package:edufy_mobile/src/shared/configs/app_endpoints.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

import 'i_lesson_repository.dart';

class LessonRepository extends BaseRepository implements ILessonRepository {
  LessonRepository({required ApiClient apiClient}) : super(dio: apiClient);

  @override
  Future<ApiResult<PaginationResponse<LessonModel>, ApiException>> index({
    int page = 1,
    int? courseId,
  }) {
    return get(
      endpoint: AppEndpoints.lessons,
      parameters: {
        'page': page,
        if (courseId != null) 'course_id': courseId,
      },
      fromMap: (json) =>
          PaginationResponse<LessonModel>.fromJson(json, LessonModel.fromJson),
    );
  }

  @override
  Future<ApiResult<ObjectResponse<LessonModel>, ApiException>> getDetail(
      int id) {
    return get(
      endpoint: '${AppEndpoints.lessons}/$id',
      fromMap: (json) =>
          ObjectResponse<LessonModel>.fromJson(json, LessonModel.fromJson),
    );
  }
}
