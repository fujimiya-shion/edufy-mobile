import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/auth/auth_dto.dart';
import 'package:edufy_mobile/src/data/dtos/common/object_response.dart';
import 'package:edufy_mobile/src/data/models/user/user_model.dart';
import 'package:edufy_mobile/src/data/repositories/auth/i_auth_repository.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

class MockAuthRepository implements IAuthRepository {
  const MockAuthRepository();

  // static const _mockUser = UserModel(
  //   id: 1,
  //   name: 'Demo User',
  //   email: 'demo@edufy.vn',
  // );

  @override
  Future<ApiResult<ObjectResponse<CheckExistResponse>, ApiException>> checkEmailExist({required String email}) {
    // TODO: implement checkEmailExist
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<ObjectResponse<UserModel>, ApiException>> me() {
    // TODO: implement me
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<ObjectResponse<UserLoginResponse>, ApiException>> userLogin({required String email, required String password}) {
    // TODO: implement userLogin
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<ObjectResponse<UserRegisterResponse>, ApiException>> userRegister({required String email, required String password, required String passwordConfirm}) {
    // TODO: implement userRegister
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<ObjectResponse<UserLoginResponse>, ApiException>> userSocialLogin({required String provider, required String idToken}) {
    // TODO: implement userSocialLogin
    throw UnimplementedError();
  }
}
