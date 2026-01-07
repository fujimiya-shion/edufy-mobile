import 'package:edufy_mobile/src/shared/types/api_result.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';

abstract class IFcmTokenRepository {
  Future<ApiResult<void, ApiException>> registerToken({
    required String token,
    String? deviceId,
    String? deviceType,
  });
}
