import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';

import 'i_teacher_repository.dart';

class MockTeacherRepository implements ITeacherRepository {
  const MockTeacherRepository();

  static const _center = TrainingCenterModel(
    id: 1,
    name: 'The Digital Lab',
    slug: 'the-digital-lab',
  );

  static const _items = <TeacherModel>[
    TeacherModel(
      id: 1,
      fullName: 'Nguyễn Văn A',
      title: 'Head of Performance',
      avatarPath: null,
      isActive: true,
      trainingCenter: _center,
    ),
    TeacherModel(
      id: 2,
      fullName: 'Trần Thị B',
      title: 'Senior Digital Strategist',
      avatarPath: null,
      isActive: true,
      trainingCenter: _center,
    ),
  ];

  @override
  Future<ApiResult<PaginationResponse<TeacherModel>, ApiException>> index({
    int page = 1,
    String? keyword,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final lowerSearch = keyword?.trim().toLowerCase();
    final filtered = (lowerSearch == null || lowerSearch.isEmpty)
        ? _items
        : _items
            .where(
              (t) => (t.fullName ?? '').toLowerCase().contains(lowerSearch),
            )
            .toList();

    const pageSize = 10;
    final start = (page - 1) * pageSize;
    final end = (start + pageSize) > filtered.length
        ? filtered.length
        : (start + pageSize);
    final paged =
        start >= filtered.length ? <TeacherModel>[] : filtered.sublist(start, end);

    final pagination = PaginationResponse<TeacherModel>(
      data: paged,
      pageCount: (filtered.length / pageSize).ceil(),
      total: filtered.length,
      page: page,
      perPage: pageSize,
    );

    return ApiResult<PaginationResponse<TeacherModel>, ApiException>(
      response: pagination,
    );
  }

  @override
  Future<ApiResult<ObjectResponse<TeacherModel>, ApiException>> getDetail(
    int id,
  ) async {
    await Future.delayed(const Duration(milliseconds: 150));

    final teacher = _items.firstWhere(
      (t) => t.id == id,
      orElse: () => _items.first,
    );

    final objectResponse = ObjectResponse<TeacherModel>(
      data: teacher,
    );

    return ApiResult<ObjectResponse<TeacherModel>, ApiException>(
      response: objectResponse,
    );
  }
}
