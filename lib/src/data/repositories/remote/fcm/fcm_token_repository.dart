import 'package:edufy_mobile/src/core/network/api_client.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/repositories/remote/base_repository.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

import 'i_fcm_token_repository.dart';

class FcmTokenRepository extends BaseRepository
    implements IFcmTokenRepository {
  FcmTokenRepository({required ApiClient apiClient}) : super(dio: apiClient);

  @override
  Future<ApiResult<void, ApiException>> registerToken({
    required String token,
    String? deviceId,
    String? deviceType,
  }) async {
    final result = await post<Map<String, dynamic>>(
      endpoint: AppEndpoints.fcmTokens,
      data: {
        'token': token,
        if (deviceId != null) 'device_id': deviceId,
        if (deviceType != null) 'device_type': deviceType,
      },
      fromMap: (json) => json,
    );

    return ApiResult(response: null, exception: result.exception);
  }
}
