// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LessonModelCWProxy {
  LessonModel id(int? id);

  LessonModel courseId(int? courseId);

  LessonModel title(String? title);

  LessonModel slug(String? slug);

  LessonModel summary(String? summary);

  LessonModel sortOrder(int? sortOrder);

  LessonModel status(LessonStatus? status);

  LessonModel course(CourseModel? course);

  LessonModel media(List<LessonMediaModel>? media);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LessonModel(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LessonModel(...).copyWith(id: 12, name: "My name")
  /// ```
  LessonModel call({
    int? id,
    int? courseId,
    String? title,
    String? slug,
    String? summary,
    int? sortOrder,
    LessonStatus? status,
    CourseModel? course,
    List<LessonMediaModel>? media,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfLessonModel.copyWith(...)` or call `instanceOfLessonModel.copyWith.fieldName(value)` for a single field.
class _$LessonModelCWProxyImpl implements _$LessonModelCWProxy {
  const _$LessonModelCWProxyImpl(this._value);

  final LessonModel _value;

  @override
  LessonModel id(int? id) => call(id: id);

  @override
  LessonModel courseId(int? courseId) => call(courseId: courseId);

  @override
  LessonModel title(String? title) => call(title: title);

  @override
  LessonModel slug(String? slug) => call(slug: slug);

  @override
  LessonModel summary(String? summary) => call(summary: summary);

  @override
  LessonModel sortOrder(int? sortOrder) => call(sortOrder: sortOrder);

  @override
  LessonModel status(LessonStatus? status) => call(status: status);

  @override
  LessonModel course(CourseModel? course) => call(course: course);

  @override
  LessonModel media(List<LessonMediaModel>? media) => call(media: media);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LessonModel(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LessonModel(...).copyWith(id: 12, name: "My name")
  /// ```
  LessonModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? courseId = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? slug = const $CopyWithPlaceholder(),
    Object? summary = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? course = const $CopyWithPlaceholder(),
    Object? media = const $CopyWithPlaceholder(),
  }) {
    return LessonModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      courseId: courseId == const $CopyWithPlaceholder()
          ? _value.courseId
          // ignore: cast_nullable_to_non_nullable
          : courseId as int?,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      slug: slug == const $CopyWithPlaceholder()
          ? _value.slug
          // ignore: cast_nullable_to_non_nullable
          : slug as String?,
      summary: summary == const $CopyWithPlaceholder()
          ? _value.summary
          // ignore: cast_nullable_to_non_nullable
          : summary as String?,
      sortOrder: sortOrder == const $CopyWithPlaceholder()
          ? _value.sortOrder
          // ignore: cast_nullable_to_non_nullable
          : sortOrder as int?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as LessonStatus?,
      course: course == const $CopyWithPlaceholder()
          ? _value.course
          // ignore: cast_nullable_to_non_nullable
          : course as CourseModel?,
      media: media == const $CopyWithPlaceholder()
          ? _value.media
          // ignore: cast_nullable_to_non_nullable
          : media as List<LessonMediaModel>?,
    );
  }
}

extension $LessonModelCopyWith on LessonModel {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfLessonModel.copyWith(...)` or `instanceOfLessonModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LessonModelCWProxy get copyWith => _$LessonModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
  id: (json['id'] as num?)?.toInt(),
  courseId: (json['course_id'] as num?)?.toInt(),
  title: json['title'] as String?,
  slug: json['slug'] as String?,
  summary: json['summary'] as String?,
  sortOrder: (json['sort_order'] as num?)?.toInt(),
  status: lessonStatusFromJson(json['status']),
  course: json['course'] == null
      ? null
      : CourseModel.fromJson(json['course'] as Map<String, dynamic>),
  media: (json['media'] as List<dynamic>?)
      ?.map((e) => LessonMediaModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_id': instance.courseId,
      'title': instance.title,
      'slug': instance.slug,
      'summary': instance.summary,
      'sort_order': instance.sortOrder,
      'status': _$LessonStatusEnumMap[instance.status],
      'course': instance.course?.toJson(),
      'media': instance.media?.map((e) => e.toJson()).toList(),
    };

const _$LessonStatusEnumMap = {
  LessonStatus.draft: 'draft',
  LessonStatus.published: 'published',
  LessonStatus.locked: 'locked',
};
