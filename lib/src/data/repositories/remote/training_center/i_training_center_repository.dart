// lib/src/data/repositories/training_center/i_training_center_repository.dart
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';

abstract class ITrainingCenterRepository {
  Future<ApiResult<PaginationResponse<TrainingCenterModel>, ApiException>> index({
    int page = 1,
    String? search,
  });

  Future<ApiResult<ObjectResponse<TrainingCenterModel>, ApiException>> getDetail(int id);
}
