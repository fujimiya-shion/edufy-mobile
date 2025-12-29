import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/object_response.dart';
import 'package:edufy_mobile/src/data/models/user/user_model.dart';
import 'package:edufy_mobile/src/data/repositories/export.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

class AuthRepository extends BaseRepository implements IAuthRepository {
  AuthRepository({required super.dio});

  @override
  Future<ApiResult<ObjectResponse<UserModel>, ApiException>> me() {
    return get(
      endpoint: AppEndpoints.me,
      fromMap: (json) => ObjectResponse<UserModel>.fromJson(json, UserModel.fromJson),
    );
  }
}
