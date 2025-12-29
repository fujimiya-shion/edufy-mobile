import 'dart:core';

import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/auth/auth_dto.dart';
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';


abstract class IAuthRepository {
  Future<ApiResult<ObjectResponse<CheckExistResponse>, ApiException>> checkEmailExist({ required String email });
  Future<ApiResult<ObjectResponse<UserRegisterResponse>, ApiException>> userRegister({ required String email, required String password, required String passwordConfirm });
  Future<ApiResult<ObjectResponse<UserLoginResponse>, ApiException>> userLogin({ required String email, required String password });
  Future<ApiResult<ObjectResponse<UserLoginResponse>, ApiException>> userSocialLogin({ required String provider, required String idToken });
  Future<ApiResult<ObjectResponse<UserModel>, ApiException>> me();
}