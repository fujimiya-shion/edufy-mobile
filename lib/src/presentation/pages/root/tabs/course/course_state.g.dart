// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CourseStateCWProxy {
  CourseState isLoading(bool isLoading);

  CourseState isLoadingMore(bool isLoadingMore);

  CourseState courses(List<CourseModel> courses);

  CourseState page(int page);

  CourseState pageCount(int pageCount);

  CourseState filterRequest(CourseFilterRequest filterRequest);

  CourseState exception(ApiException? exception);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CourseState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CourseState(...).copyWith(id: 12, name: "My name")
  /// ```
  CourseState call({
    bool isLoading,
    bool isLoadingMore,
    List<CourseModel> courses,
    int page,
    int pageCount,
    CourseFilterRequest filterRequest,
    ApiException? exception,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCourseState.copyWith(...)` or call `instanceOfCourseState.copyWith.fieldName(value)` for a single field.
class _$CourseStateCWProxyImpl implements _$CourseStateCWProxy {
  const _$CourseStateCWProxyImpl(this._value);

  final CourseState _value;

  @override
  CourseState isLoading(bool isLoading) => call(isLoading: isLoading);

  @override
  CourseState isLoadingMore(bool isLoadingMore) =>
      call(isLoadingMore: isLoadingMore);

  @override
  CourseState courses(List<CourseModel> courses) => call(courses: courses);

  @override
  CourseState page(int page) => call(page: page);

  @override
  CourseState pageCount(int pageCount) => call(pageCount: pageCount);

  @override
  CourseState filterRequest(CourseFilterRequest filterRequest) =>
      call(filterRequest: filterRequest);

  @override
  CourseState exception(ApiException? exception) => call(exception: exception);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CourseState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CourseState(...).copyWith(id: 12, name: "My name")
  /// ```
  CourseState call({
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? isLoadingMore = const $CopyWithPlaceholder(),
    Object? courses = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? pageCount = const $CopyWithPlaceholder(),
    Object? filterRequest = const $CopyWithPlaceholder(),
    Object? exception = const $CopyWithPlaceholder(),
  }) {
    return CourseState(
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      isLoadingMore:
          isLoadingMore == const $CopyWithPlaceholder() || isLoadingMore == null
          ? _value.isLoadingMore
          // ignore: cast_nullable_to_non_nullable
          : isLoadingMore as bool,
      courses: courses == const $CopyWithPlaceholder() || courses == null
          ? _value.courses
          // ignore: cast_nullable_to_non_nullable
          : courses as List<CourseModel>,
      page: page == const $CopyWithPlaceholder() || page == null
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      pageCount: pageCount == const $CopyWithPlaceholder() || pageCount == null
          ? _value.pageCount
          // ignore: cast_nullable_to_non_nullable
          : pageCount as int,
      filterRequest:
          filterRequest == const $CopyWithPlaceholder() || filterRequest == null
          ? _value.filterRequest
          // ignore: cast_nullable_to_non_nullable
          : filterRequest as CourseFilterRequest,
      exception: exception == const $CopyWithPlaceholder()
          ? _value.exception
          // ignore: cast_nullable_to_non_nullable
          : exception as ApiException?,
    );
  }
}

extension $CourseStateCopyWith on CourseState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCourseState.copyWith(...)` or `instanceOfCourseState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CourseStateCWProxy get copyWith => _$CourseStateCWProxyImpl(this);
}
