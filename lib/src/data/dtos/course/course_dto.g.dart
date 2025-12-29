// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CourseFilterRequestCWProxy {
  CourseFilterRequest keyword(String keyword);

  CourseFilterRequest level(String? level);

  CourseFilterRequest minFee(double? minFee);

  CourseFilterRequest maxFee(double? maxFee);

  CourseFilterRequest sort(String? sort);

  CourseFilterRequest page(int page);

  CourseFilterRequest perPage(int perPage);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CourseFilterRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CourseFilterRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  CourseFilterRequest call({
    String keyword,
    String? level,
    double? minFee,
    double? maxFee,
    String? sort,
    int page,
    int perPage,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCourseFilterRequest.copyWith(...)` or call `instanceOfCourseFilterRequest.copyWith.fieldName(value)` for a single field.
class _$CourseFilterRequestCWProxyImpl implements _$CourseFilterRequestCWProxy {
  const _$CourseFilterRequestCWProxyImpl(this._value);

  final CourseFilterRequest _value;

  @override
  CourseFilterRequest keyword(String keyword) => call(keyword: keyword);

  @override
  CourseFilterRequest level(String? level) => call(level: level);

  @override
  CourseFilterRequest minFee(double? minFee) => call(minFee: minFee);

  @override
  CourseFilterRequest maxFee(double? maxFee) => call(maxFee: maxFee);

  @override
  CourseFilterRequest sort(String? sort) => call(sort: sort);

  @override
  CourseFilterRequest page(int page) => call(page: page);

  @override
  CourseFilterRequest perPage(int perPage) => call(perPage: perPage);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CourseFilterRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CourseFilterRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  CourseFilterRequest call({
    Object? keyword = const $CopyWithPlaceholder(),
    Object? level = const $CopyWithPlaceholder(),
    Object? minFee = const $CopyWithPlaceholder(),
    Object? maxFee = const $CopyWithPlaceholder(),
    Object? sort = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? perPage = const $CopyWithPlaceholder(),
  }) {
    return CourseFilterRequest(
      keyword: keyword == const $CopyWithPlaceholder() || keyword == null
          ? _value.keyword
          // ignore: cast_nullable_to_non_nullable
          : keyword as String,
      level: level == const $CopyWithPlaceholder()
          ? _value.level
          // ignore: cast_nullable_to_non_nullable
          : level as String?,
      minFee: minFee == const $CopyWithPlaceholder()
          ? _value.minFee
          // ignore: cast_nullable_to_non_nullable
          : minFee as double?,
      maxFee: maxFee == const $CopyWithPlaceholder()
          ? _value.maxFee
          // ignore: cast_nullable_to_non_nullable
          : maxFee as double?,
      sort: sort == const $CopyWithPlaceholder()
          ? _value.sort
          // ignore: cast_nullable_to_non_nullable
          : sort as String?,
      page: page == const $CopyWithPlaceholder() || page == null
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      perPage: perPage == const $CopyWithPlaceholder() || perPage == null
          ? _value.perPage
          // ignore: cast_nullable_to_non_nullable
          : perPage as int,
    );
  }
}

extension $CourseFilterRequestCopyWith on CourseFilterRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCourseFilterRequest.copyWith(...)` or `instanceOfCourseFilterRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CourseFilterRequestCWProxy get copyWith =>
      _$CourseFilterRequestCWProxyImpl(this);
}
