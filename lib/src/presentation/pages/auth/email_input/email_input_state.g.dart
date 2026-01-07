// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_input_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmailInputStateCWProxy {
  EmailInputState email(String email);

  EmailInputState isLoading(bool isLoading);

  EmailInputState isGoogleLoading(bool isGoogleLoading);

  EmailInputState isSuccess(bool isSuccess);

  EmailInputState isGoogleSuccess(bool isGoogleSuccess);

  EmailInputState isEmailExist(bool? isEmailExist);

  EmailInputState exception(ApiException? exception);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmailInputState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmailInputState(...).copyWith(id: 12, name: "My name")
  /// ```
  EmailInputState call({
    String email,
    bool isLoading,
    bool isGoogleLoading,
    bool isSuccess,
    bool isGoogleSuccess,
    bool? isEmailExist,
    ApiException? exception,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmailInputState.copyWith(...)` or call `instanceOfEmailInputState.copyWith.fieldName(value)` for a single field.
class _$EmailInputStateCWProxyImpl implements _$EmailInputStateCWProxy {
  const _$EmailInputStateCWProxyImpl(this._value);

  final EmailInputState _value;

  @override
  EmailInputState email(String email) => call(email: email);

  @override
  EmailInputState isLoading(bool isLoading) => call(isLoading: isLoading);

  @override
  EmailInputState isGoogleLoading(bool isGoogleLoading) =>
      call(isGoogleLoading: isGoogleLoading);

  @override
  EmailInputState isSuccess(bool isSuccess) => call(isSuccess: isSuccess);

  @override
  EmailInputState isGoogleSuccess(bool isGoogleSuccess) =>
      call(isGoogleSuccess: isGoogleSuccess);

  @override
  EmailInputState isEmailExist(bool? isEmailExist) =>
      call(isEmailExist: isEmailExist);

  @override
  EmailInputState exception(ApiException? exception) =>
      call(exception: exception);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmailInputState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmailInputState(...).copyWith(id: 12, name: "My name")
  /// ```
  EmailInputState call({
    Object? email = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? isGoogleLoading = const $CopyWithPlaceholder(),
    Object? isSuccess = const $CopyWithPlaceholder(),
    Object? isGoogleSuccess = const $CopyWithPlaceholder(),
    Object? isEmailExist = const $CopyWithPlaceholder(),
    Object? exception = const $CopyWithPlaceholder(),
  }) {
    return EmailInputState(
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      isGoogleLoading:
          isGoogleLoading == const $CopyWithPlaceholder() ||
              isGoogleLoading == null
          ? _value.isGoogleLoading
          // ignore: cast_nullable_to_non_nullable
          : isGoogleLoading as bool,
      isSuccess: isSuccess == const $CopyWithPlaceholder() || isSuccess == null
          ? _value.isSuccess
          // ignore: cast_nullable_to_non_nullable
          : isSuccess as bool,
      isGoogleSuccess:
          isGoogleSuccess == const $CopyWithPlaceholder() ||
              isGoogleSuccess == null
          ? _value.isGoogleSuccess
          // ignore: cast_nullable_to_non_nullable
          : isGoogleSuccess as bool,
      isEmailExist: isEmailExist == const $CopyWithPlaceholder()
          ? _value.isEmailExist
          // ignore: cast_nullable_to_non_nullable
          : isEmailExist as bool?,
      exception: exception == const $CopyWithPlaceholder()
          ? _value.exception
          // ignore: cast_nullable_to_non_nullable
          : exception as ApiException?,
    );
  }
}

extension $EmailInputStateCopyWith on EmailInputState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmailInputState.copyWith(...)` or `instanceOfEmailInputState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmailInputStateCWProxy get copyWith => _$EmailInputStateCWProxyImpl(this);
}
