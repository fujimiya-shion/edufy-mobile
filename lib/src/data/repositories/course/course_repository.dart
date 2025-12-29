import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/dtos/course/course_dto.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/base_repository.dart';
import 'package:edufy_mobile/src/data/repositories/course/i_course_repository.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

class CourseRepository extends BaseRepository implements ICourseRepository {

  CourseRepository({required super.dio});

  @override
  Future<ApiResult<PaginationResponse<CourseModel>, ApiException>> index({ int page = 1, String? keyword }) async {
    return get(
      endpoint: AppEndpoints.courses,
      parameters: {'page': page, 'keyword': keyword},
      fromMap: (json) => PaginationResponse<CourseModel>.fromJson(json, CourseModel.fromJson),
    );
  }

  @override
  Future<ApiResult<ObjectResponse<CourseModel>, ApiException>> getDetail(int id) async {
    return get(
      endpoint: AppEndpoints.courseDetail(id),
      fromMap: (json) => ObjectResponse<CourseModel>.fromJson(json, CourseModel.fromJson),
    );
  }

  @override
  Future<ApiResult<PaginationResponse<CourseModel>, ApiException>> filter({CourseFilterRequest request = const CourseFilterRequest(page: 1, perPage: 15)}) {
    return get(
      endpoint: AppEndpoints.coursesFilter,
      parameters: request.toQuery(),
      fromMap: (json) => PaginationResponse<CourseModel>.fromJson(json, CourseModel.fromJson),
    );
  }
}
