import 'package:edufy_mobile/src/core/network/api_client.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/remote/base_repository.dart';
import 'package:edufy_mobile/src/shared/configs/app_endpoints.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

import 'i_teacher_repository.dart';

class TeacherRepository extends BaseRepository implements ITeacherRepository {
  TeacherRepository({required ApiClient apiClient}) : super(dio: apiClient);

  @override
  Future<ApiResult<PaginationResponse<TeacherModel>, ApiException>> index({
    int page = 1,
    String? keyword,
  }) {
    final hasSearch = keyword != null && keyword.trim().isNotEmpty;
    final endpoint =
        hasSearch ? AppEndpoints.teachersSearch : AppEndpoints.teachers;

    final params = <String, dynamic>{
      'page': page,
      if (hasSearch) 'q': keyword.trim(),
    };

    return get<PaginationResponse<TeacherModel>>(
      endpoint: endpoint,
      parameters: params.isEmpty ? null : params,
      fromMap: (json) {
        final list = (json['data'] ?? json) as List;
        final items = list
            .map((e) => TeacherModel.fromJson(e as Map<String, dynamic>))
            .toList();

        final meta = json['meta'] as Map<String, dynamic>?;

        return PaginationResponse<TeacherModel>(
          data: items,
          page: meta?['current_page'] ?? page,
          perPage: meta?['per_page'] ?? items.length,
          total: meta?['total'] ?? items.length,
          pageCount: meta?['last_page'] ?? 1,
        );
      },
    );
  }

  @override
  Future<ApiResult<ObjectResponse<TeacherModel>, ApiException>> getDetail(
    int id,
  ) {
    return get<ObjectResponse<TeacherModel>>(
      endpoint: '${AppEndpoints.teachers}/$id',
      fromMap: (json) {
        final data = (json['data'] ?? json) as Map<String, dynamic>;
        final teacher = TeacherModel.fromJson(data);
        return ObjectResponse<TeacherModel>(
          data: teacher,
        );
      },
    );
  }
}
