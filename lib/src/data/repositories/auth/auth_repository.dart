import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/auth/auth_dto.dart';
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/auth/export.dart';
import 'package:edufy_mobile/src/data/repositories/base_repository.dart';
import 'package:edufy_mobile/src/shared/configs/app_endpoints.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

class AuthRepository extends BaseRepository implements IAuthRepository {

  AuthRepository({required super.dio});

  @override
  Future<ApiResult<ObjectResponse<CheckExistResponse>, ApiException>> checkEmailExist({required String email}) {
    return post(
      endpoint: AppEndpoints.checkEmailExist,
      data: {'email': email},
      fromMap: (map) => ObjectResponse.fromJson(map, CheckExistResponse.fromJson),
    );
  }

  
  @override
  Future<ApiResult<ObjectResponse<UserRegisterResponse>, ApiException>> userRegister({required String email, required String password, required String passwordConfirm}) {
    return post(
      endpoint: AppEndpoints.register,
      data: {'phone': email, 'password': password, 'password_confirmation': passwordConfirm},
      fromMap: (map) => ObjectResponse.fromJson(map, UserRegisterResponse.fromJson),
    );
  }
  
  @override
  Future<ApiResult<ObjectResponse<UserLoginResponse>, ApiException>> userLogin({required String email, required String password}) {
    return post(
      endpoint: AppEndpoints.login,
      data: {'email': email, 'password': password},
      fromMap: (map) => ObjectResponse.fromJson(map, UserLoginResponse.fromJson),
    );
  }

  @override
  Future<ApiResult<ObjectResponse<UserModel>, ApiException>> me() {
    return get(
      endpoint: AppEndpoints.me,
      fromMap: (map) => ObjectResponse.fromJson(map, UserModel.fromJson),
    );
  }
  
  @override
  Future<ApiResult<ObjectResponse<UserLoginResponse>, ApiException>> userSocialLogin({required String provider, required String idToken}) {
    return post(
      endpoint: AppEndpoints.loginSocial(provider),
      data: { 'id_token': idToken },
      fromMap: (map) => ObjectResponse.fromJson(map, UserLoginResponse.fromJson),
    );
  }

}