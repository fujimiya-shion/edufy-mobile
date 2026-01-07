import 'package:edufy_mobile/src/shared/types/api_result.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';

import 'i_fcm_token_repository.dart';

class MockFcmTokenRepository implements IFcmTokenRepository {
  @override
  Future<ApiResult<void, ApiException>> registerToken({
    required String token,
    String? deviceId,
    String? deviceType,
  }) async {
    // chỉ giả lập, không call network
    await Future.delayed(const Duration(milliseconds: 100));
    return const ApiResult(response: null);
  }
}
