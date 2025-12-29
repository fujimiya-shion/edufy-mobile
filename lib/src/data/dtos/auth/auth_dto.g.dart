// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckExistResponse _$CheckExistResponseFromJson(Map<String, dynamic> json) =>
    CheckExistResponse(
      exists: json['exists'] as bool,
      fullName: json['full_name'] as String?,
    );

Map<String, dynamic> _$CheckExistResponseToJson(CheckExistResponse instance) =>
    <String, dynamic>{
      'exists': instance.exists,
      'full_name': instance.fullName,
    };

UserRegisterResponse _$UserRegisterResponseFromJson(
  Map<String, dynamic> json,
) => UserRegisterResponse(
  token: json['token'] as String,
  user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserRegisterResponseToJson(
  UserRegisterResponse instance,
) => <String, dynamic>{'token': instance.token, 'user': instance.user};

UserLoginResponse _$UserLoginResponseFromJson(Map<String, dynamic> json) =>
    UserLoginResponse(
      token: json['token'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserLoginResponseToJson(UserLoginResponse instance) =>
    <String, dynamic>{'token': instance.token, 'user': instance.user};

ForgotPasswordResponse _$ForgotPasswordResponseFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordResponse();

Map<String, dynamic> _$ForgotPasswordResponseToJson(
  ForgotPasswordResponse instance,
) => <String, dynamic>{};

ResetPasswordResponse _$ResetPasswordResponseFromJson(
  Map<String, dynamic> json,
) => ResetPasswordResponse();

Map<String, dynamic> _$ResetPasswordResponseToJson(
  ResetPasswordResponse instance,
) => <String, dynamic>{};
