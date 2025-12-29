// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CourseFilterRequestCWProxy {
  CourseFilterRequest keyword(String keyword);

  CourseFilterRequest trainingCenterId(int? trainingCenterId);

  CourseFilterRequest level(String? level);

  CourseFilterRequest status(String? status);

  CourseFilterRequest minFee(double? minFee);

  CourseFilterRequest maxFee(double? maxFee);

  CourseFilterRequest teacherId(int? teacherId);

  CourseFilterRequest hasMedia(bool? hasMedia);

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
    int? trainingCenterId,
    String? level,
    String? status,
    double? minFee,
    double? maxFee,
    int? teacherId,
    bool? hasMedia,
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
  CourseFilterRequest trainingCenterId(int? trainingCenterId) =>
      call(trainingCenterId: trainingCenterId);

  @override
  CourseFilterRequest level(String? level) => call(level: level);

  @override
  CourseFilterRequest status(String? status) => call(status: status);

  @override
  CourseFilterRequest minFee(double? minFee) => call(minFee: minFee);

  @override
  CourseFilterRequest maxFee(double? maxFee) => call(maxFee: maxFee);

  @override
  CourseFilterRequest teacherId(int? teacherId) => call(teacherId: teacherId);

  @override
  CourseFilterRequest hasMedia(bool? hasMedia) => call(hasMedia: hasMedia);

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
    Object? trainingCenterId = const $CopyWithPlaceholder(),
    Object? level = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? minFee = const $CopyWithPlaceholder(),
    Object? maxFee = const $CopyWithPlaceholder(),
    Object? teacherId = const $CopyWithPlaceholder(),
    Object? hasMedia = const $CopyWithPlaceholder(),
    Object? sort = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? perPage = const $CopyWithPlaceholder(),
  }) {
    return CourseFilterRequest(
      keyword: keyword == const $CopyWithPlaceholder() || keyword == null
          ? _value.keyword
          // ignore: cast_nullable_to_non_nullable
          : keyword as String,
      trainingCenterId: trainingCenterId == const $CopyWithPlaceholder()
          ? _value.trainingCenterId
          // ignore: cast_nullable_to_non_nullable
          : trainingCenterId as int?,
      level: level == const $CopyWithPlaceholder()
          ? _value.level
          // ignore: cast_nullable_to_non_nullable
          : level as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String?,
      minFee: minFee == const $CopyWithPlaceholder()
          ? _value.minFee
          // ignore: cast_nullable_to_non_nullable
          : minFee as double?,
      maxFee: maxFee == const $CopyWithPlaceholder()
          ? _value.maxFee
          // ignore: cast_nullable_to_non_nullable
          : maxFee as double?,
      teacherId: teacherId == const $CopyWithPlaceholder()
          ? _value.teacherId
          // ignore: cast_nullable_to_non_nullable
          : teacherId as int?,
      hasMedia: hasMedia == const $CopyWithPlaceholder()
          ? _value.hasMedia
          // ignore: cast_nullable_to_non_nullable
          : hasMedia as bool?,
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
