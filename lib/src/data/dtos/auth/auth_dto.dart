import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_dto.g.dart';

@JsonSerializable()
class CheckExistResponse {
  final bool exists;
  @JsonKey(name: 'full_name')
  final String? fullName;

  const CheckExistResponse({
    required this.exists,
    this.fullName,
  });

  factory CheckExistResponse.fromJson(Map<String, dynamic> json) => _$CheckExistResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckExistResponseToJson(this);
}

@JsonSerializable()
class UserRegisterResponse {
  final String token;
  final UserModel user;

  const UserRegisterResponse({
    required this.token,
    required this.user,
  });

  factory UserRegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterResponseToJson(this);
}

@JsonSerializable()
class UserLoginResponse {
  final String token;
  final UserModel user;

  const UserLoginResponse({
    required this.token,
    required this.user,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginResponseToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse {
  const ForgotPasswordResponse();

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}

@JsonSerializable()
class ResetPasswordResponse {
  const ResetPasswordResponse();

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);
}
