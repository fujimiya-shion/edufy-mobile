import 'package:edufy_mobile/src/core/network/api_client.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/remote/base_repository.dart';
import 'package:edufy_mobile/src/shared/configs/app_endpoints.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

import 'i_training_center_repository.dart';

class TrainingCenterRepository extends BaseRepository
    implements ITrainingCenterRepository {
  TrainingCenterRepository({required ApiClient apiClient})
      : super(dio: apiClient);

  @override
  Future<ApiResult<PaginationResponse<TrainingCenterModel>, ApiException>> index({
    int page = 1,
    String? search,
  }) {
    return get(
      endpoint: AppEndpoints.trainingCenters,
      parameters: {
        'page': page,
        if (search != null && search.trim().isNotEmpty) 'keyword': search.trim(),
      },
      fromMap: (json) =>
          PaginationResponse<TrainingCenterModel>.fromJson(json, TrainingCenterModel.fromJson),
    );
  }

  @override
  Future<ApiResult<ObjectResponse<TrainingCenterModel>, ApiException>> getDetail(int id) {
    return get(
      endpoint: '${AppEndpoints.trainingCenters}/$id',
      fromMap: (json) =>
          ObjectResponse<TrainingCenterModel>.fromJson(json, TrainingCenterModel.fromJson),
    );
  }
}
