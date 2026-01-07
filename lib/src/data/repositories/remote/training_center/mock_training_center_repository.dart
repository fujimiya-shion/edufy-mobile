import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

import 'i_training_center_repository.dart';

class MockTrainingCenterRepository implements ITrainingCenterRepository {
  const MockTrainingCenterRepository();

  static const _items = <TrainingCenterModel>[
    TrainingCenterModel(
      id: 1,
      name: 'The Digital Lab',
      slug: 'the-digital-lab',
      city: 'Ho Chi Minh',
      country: 'Vietnam',
      timezone: 'Asia/Ho_Chi_Minh',
    ),
    TrainingCenterModel(
      id: 2,
      name: 'Edufy Hub',
      slug: 'edufy-hub',
      city: 'Ha Noi',
      country: 'Vietnam',
      timezone: 'Asia/Ho_Chi_Minh',
    ),
  ];

  @override
  Future<ApiResult<PaginationResponse<TrainingCenterModel>, ApiException>> index({
    int page = 1,
    String? search,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final lower = search?.trim().toLowerCase();
    final filtered = (lower == null || lower.isEmpty)
        ? _items
        : _items
            .where((c) => (c.name ?? '').toLowerCase().contains(lower))
            .toList();

    const pageSize = 10;
    final start = (page - 1) * pageSize;
    final end = (start + pageSize > filtered.length)
        ? filtered.length
        : start + pageSize;

    final paged = start >= filtered.length
        ? <TrainingCenterModel>[]
        : filtered.sublist(start, end);

    final pagination = PaginationResponse<TrainingCenterModel>(
      data: paged,
      total: filtered.length,
      page: page,
      perPage: pageSize,
      pageCount: (filtered.length / pageSize).ceil(),
    );

    return ApiResult(response: pagination);
  }

  @override
  Future<ApiResult<ObjectResponse<TrainingCenterModel>, ApiException>> getDetail(int id) async {
    await Future.delayed(const Duration(milliseconds: 150));

    final center = _items.firstWhere(
      (c) => c.id == id,
      orElse: () => _items.first,
    );

    return ApiResult(
      response: ObjectResponse<TrainingCenterModel>(data: center),
    );
  }
}
