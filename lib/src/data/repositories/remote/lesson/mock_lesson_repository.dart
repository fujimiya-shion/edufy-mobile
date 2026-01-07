import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

import 'i_lesson_repository.dart';

class MockLessonRepository implements ILessonRepository {
  const MockLessonRepository();

  static const _lessons = <LessonModel>[
    LessonModel(
      id: 1,
      courseId: 1,
      title: 'Giới thiệu Digital Marketing',
      slug: 'gioi-thieu-digital-marketing',
      sortOrder: 1,
    ),
    LessonModel(
      id: 2,
      courseId: 1,
      title: 'Customer Journey & Funnel',
      slug: 'customer-journey-funnel',
      sortOrder: 2,
    ),
  ];

  @override
  Future<ApiResult<PaginationResponse<LessonModel>, ApiException>> index({
    int page = 1,
    int? courseId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final filtered = courseId == null
        ? _lessons
        : _lessons.where((l) => l.courseId == courseId).toList();

    const pageSize = 10;
    final start = (page - 1) * pageSize;
    final end =
        (start + pageSize) > filtered.length ? filtered.length : start + pageSize;

    final paged = start >= filtered.length
        ? <LessonModel>[]
        : filtered.sublist(start, end);

    final pagination = PaginationResponse<LessonModel>(
      data: paged,
      total: filtered.length,
      page: page,
      perPage: pageSize,
      pageCount: (filtered.length / pageSize).ceil(),
    );

    return ApiResult(response: pagination);
  }

  @override
  Future<ApiResult<ObjectResponse<LessonModel>, ApiException>> getDetail(
    int id,
  ) async {
    await Future.delayed(const Duration(milliseconds: 150));

    final lesson = _lessons.firstWhere(
      (l) => l.id == id,
      orElse: () => _lessons.first,
    );

    return ApiResult(
      response: ObjectResponse<LessonModel>(data: lesson),
    );
  }
}
