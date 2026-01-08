// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SplashStateCWProxy {
  SplashState status(AppStatus status);

  SplashState exception(ApiException? exception);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SplashState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SplashState(...).copyWith(id: 12, name: "My name")
  /// ```
  SplashState call({AppStatus status, ApiException? exception});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSplashState.copyWith(...)` or call `instanceOfSplashState.copyWith.fieldName(value)` for a single field.
class _$SplashStateCWProxyImpl implements _$SplashStateCWProxy {
  const _$SplashStateCWProxyImpl(this._value);

  final SplashState _value;

  @override
  SplashState status(AppStatus status) => call(status: status);

  @override
  SplashState exception(ApiException? exception) => call(exception: exception);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SplashState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SplashState(...).copyWith(id: 12, name: "My name")
  /// ```
  SplashState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? exception = const $CopyWithPlaceholder(),
  }) {
    return SplashState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as AppStatus,
      exception: exception == const $CopyWithPlaceholder()
          ? _value.exception
          // ignore: cast_nullable_to_non_nullable
          : exception as ApiException?,
    );
  }
}

extension $SplashStateCopyWith on SplashState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSplashState.copyWith(...)` or `instanceOfSplashState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SplashStateCWProxy get copyWith => _$SplashStateCWProxyImpl(this);
}
