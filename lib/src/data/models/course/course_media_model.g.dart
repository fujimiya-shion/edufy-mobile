// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_media_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CourseMediaModelCWProxy {
  CourseMediaModel id(String? id);

  CourseMediaModel courseId(int? courseId);

  CourseMediaModel type(String? type);

  CourseMediaModel title(String? title);

  CourseMediaModel url(String? url);

  CourseMediaModel sortOrder(int? sortOrder);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CourseMediaModel(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CourseMediaModel(...).copyWith(id: 12, name: "My name")
  /// ```
  CourseMediaModel call({
    String? id,
    int? courseId,
    String? type,
    String? title,
    String? url,
    int? sortOrder,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCourseMediaModel.copyWith(...)` or call `instanceOfCourseMediaModel.copyWith.fieldName(value)` for a single field.
class _$CourseMediaModelCWProxyImpl implements _$CourseMediaModelCWProxy {
  const _$CourseMediaModelCWProxyImpl(this._value);

  final CourseMediaModel _value;

  @override
  CourseMediaModel id(String? id) => call(id: id);

  @override
  CourseMediaModel courseId(int? courseId) => call(courseId: courseId);

  @override
  CourseMediaModel type(String? type) => call(type: type);

  @override
  CourseMediaModel title(String? title) => call(title: title);

  @override
  CourseMediaModel url(String? url) => call(url: url);

  @override
  CourseMediaModel sortOrder(int? sortOrder) => call(sortOrder: sortOrder);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CourseMediaModel(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CourseMediaModel(...).copyWith(id: 12, name: "My name")
  /// ```
  CourseMediaModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? courseId = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return CourseMediaModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      courseId: courseId == const $CopyWithPlaceholder()
          ? _value.courseId
          // ignore: cast_nullable_to_non_nullable
          : courseId as int?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String?,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      url: url == const $CopyWithPlaceholder()
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String?,
      sortOrder: sortOrder == const $CopyWithPlaceholder()
          ? _value.sortOrder
          // ignore: cast_nullable_to_non_nullable
          : sortOrder as int?,
    );
  }
}

extension $CourseMediaModelCopyWith on CourseMediaModel {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCourseMediaModel.copyWith(...)` or `instanceOfCourseMediaModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CourseMediaModelCWProxy get copyWith => _$CourseMediaModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseMediaModel _$CourseMediaModelFromJson(Map<String, dynamic> json) =>
    CourseMediaModel(
      id: json['id'] as String?,
      courseId: (json['course_id'] as num?)?.toInt(),
      type: json['type'] as String?,
      title: json['title'] as String?,
      url: json['url'] as String?,
      sortOrder: (json['sort_order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CourseMediaModelToJson(CourseMediaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_id': instance.courseId,
      'type': instance.type,
      'title': instance.title,
      'url': instance.url,
      'sort_order': instance.sortOrder,
    };
