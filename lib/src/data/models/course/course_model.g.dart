// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CourseModelCWProxy {
  CourseModel id(int? id);

  CourseModel trainingCenterId(int? trainingCenterId);

  CourseModel title(String? title);

  CourseModel slug(String? slug);

  CourseModel code(String? code);

  CourseModel shortDescription(String? shortDescription);

  CourseModel description(String? description);

  CourseModel level(CourseLevel? level);

  CourseModel status(CourseStatus? status);

  CourseModel durationHours(int? durationHours);

  CourseModel capacity(int? capacity);

  CourseModel tuitionFee(double? tuitionFee);

  CourseModel startDate(DateTime? startDate);

  CourseModel endDate(DateTime? endDate);

  CourseModel coverImagePath(String? coverImagePath);

  CourseModel meta(Map<String, dynamic>? meta);

  CourseModel trainingCenter(TrainingCenterModel? trainingCenter);

  CourseModel teachers(List<TeacherModel>? teachers);

  CourseModel schedules(List<CourseScheduleModel>? schedules);

  CourseModel media(List<CourseMediaModel>? media);

  CourseModel lessons(List<LessonModel>? lessons);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CourseModel(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CourseModel(...).copyWith(id: 12, name: "My name")
  /// ```
  CourseModel call({
    int? id,
    int? trainingCenterId,
    String? title,
    String? slug,
    String? code,
    String? shortDescription,
    String? description,
    CourseLevel? level,
    CourseStatus? status,
    int? durationHours,
    int? capacity,
    double? tuitionFee,
    DateTime? startDate,
    DateTime? endDate,
    String? coverImagePath,
    Map<String, dynamic>? meta,
    TrainingCenterModel? trainingCenter,
    List<TeacherModel>? teachers,
    List<CourseScheduleModel>? schedules,
    List<CourseMediaModel>? media,
    List<LessonModel>? lessons,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCourseModel.copyWith(...)` or call `instanceOfCourseModel.copyWith.fieldName(value)` for a single field.
class _$CourseModelCWProxyImpl implements _$CourseModelCWProxy {
  const _$CourseModelCWProxyImpl(this._value);

  final CourseModel _value;

  @override
  CourseModel id(int? id) => call(id: id);

  @override
  CourseModel trainingCenterId(int? trainingCenterId) =>
      call(trainingCenterId: trainingCenterId);

  @override
  CourseModel title(String? title) => call(title: title);

  @override
  CourseModel slug(String? slug) => call(slug: slug);

  @override
  CourseModel code(String? code) => call(code: code);

  @override
  CourseModel shortDescription(String? shortDescription) =>
      call(shortDescription: shortDescription);

  @override
  CourseModel description(String? description) =>
      call(description: description);

  @override
  CourseModel level(CourseLevel? level) => call(level: level);

  @override
  CourseModel status(CourseStatus? status) => call(status: status);

  @override
  CourseModel durationHours(int? durationHours) =>
      call(durationHours: durationHours);

  @override
  CourseModel capacity(int? capacity) => call(capacity: capacity);

  @override
  CourseModel tuitionFee(double? tuitionFee) => call(tuitionFee: tuitionFee);

  @override
  CourseModel startDate(DateTime? startDate) => call(startDate: startDate);

  @override
  CourseModel endDate(DateTime? endDate) => call(endDate: endDate);

  @override
  CourseModel coverImagePath(String? coverImagePath) =>
      call(coverImagePath: coverImagePath);

  @override
  CourseModel meta(Map<String, dynamic>? meta) => call(meta: meta);

  @override
  CourseModel trainingCenter(TrainingCenterModel? trainingCenter) =>
      call(trainingCenter: trainingCenter);

  @override
  CourseModel teachers(List<TeacherModel>? teachers) =>
      call(teachers: teachers);

  @override
  CourseModel schedules(List<CourseScheduleModel>? schedules) =>
      call(schedules: schedules);

  @override
  CourseModel media(List<CourseMediaModel>? media) => call(media: media);

  @override
  CourseModel lessons(List<LessonModel>? lessons) => call(lessons: lessons);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CourseModel(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CourseModel(...).copyWith(id: 12, name: "My name")
  /// ```
  CourseModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? trainingCenterId = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? slug = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? shortDescription = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? level = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? durationHours = const $CopyWithPlaceholder(),
    Object? capacity = const $CopyWithPlaceholder(),
    Object? tuitionFee = const $CopyWithPlaceholder(),
    Object? startDate = const $CopyWithPlaceholder(),
    Object? endDate = const $CopyWithPlaceholder(),
    Object? coverImagePath = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
    Object? trainingCenter = const $CopyWithPlaceholder(),
    Object? teachers = const $CopyWithPlaceholder(),
    Object? schedules = const $CopyWithPlaceholder(),
    Object? media = const $CopyWithPlaceholder(),
    Object? lessons = const $CopyWithPlaceholder(),
  }) {
    return CourseModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      trainingCenterId: trainingCenterId == const $CopyWithPlaceholder()
          ? _value.trainingCenterId
          // ignore: cast_nullable_to_non_nullable
          : trainingCenterId as int?,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      slug: slug == const $CopyWithPlaceholder()
          ? _value.slug
          // ignore: cast_nullable_to_non_nullable
          : slug as String?,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String?,
      shortDescription: shortDescription == const $CopyWithPlaceholder()
          ? _value.shortDescription
          // ignore: cast_nullable_to_non_nullable
          : shortDescription as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      level: level == const $CopyWithPlaceholder()
          ? _value.level
          // ignore: cast_nullable_to_non_nullable
          : level as CourseLevel?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as CourseStatus?,
      durationHours: durationHours == const $CopyWithPlaceholder()
          ? _value.durationHours
          // ignore: cast_nullable_to_non_nullable
          : durationHours as int?,
      capacity: capacity == const $CopyWithPlaceholder()
          ? _value.capacity
          // ignore: cast_nullable_to_non_nullable
          : capacity as int?,
      tuitionFee: tuitionFee == const $CopyWithPlaceholder()
          ? _value.tuitionFee
          // ignore: cast_nullable_to_non_nullable
          : tuitionFee as double?,
      startDate: startDate == const $CopyWithPlaceholder()
          ? _value.startDate
          // ignore: cast_nullable_to_non_nullable
          : startDate as DateTime?,
      endDate: endDate == const $CopyWithPlaceholder()
          ? _value.endDate
          // ignore: cast_nullable_to_non_nullable
          : endDate as DateTime?,
      coverImagePath: coverImagePath == const $CopyWithPlaceholder()
          ? _value.coverImagePath
          // ignore: cast_nullable_to_non_nullable
          : coverImagePath as String?,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as Map<String, dynamic>?,
      trainingCenter: trainingCenter == const $CopyWithPlaceholder()
          ? _value.trainingCenter
          // ignore: cast_nullable_to_non_nullable
          : trainingCenter as TrainingCenterModel?,
      teachers: teachers == const $CopyWithPlaceholder()
          ? _value.teachers
          // ignore: cast_nullable_to_non_nullable
          : teachers as List<TeacherModel>?,
      schedules: schedules == const $CopyWithPlaceholder()
          ? _value.schedules
          // ignore: cast_nullable_to_non_nullable
          : schedules as List<CourseScheduleModel>?,
      media: media == const $CopyWithPlaceholder()
          ? _value.media
          // ignore: cast_nullable_to_non_nullable
          : media as List<CourseMediaModel>?,
      lessons: lessons == const $CopyWithPlaceholder()
          ? _value.lessons
          // ignore: cast_nullable_to_non_nullable
          : lessons as List<LessonModel>?,
    );
  }
}

extension $CourseModelCopyWith on CourseModel {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCourseModel.copyWith(...)` or `instanceOfCourseModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CourseModelCWProxy get copyWith => _$CourseModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
  id: (json['id'] as num?)?.toInt(),
  trainingCenterId: (json['training_center_id'] as num?)?.toInt(),
  title: json['title'] as String?,
  slug: json['slug'] as String?,
  code: json['code'] as String?,
  shortDescription: json['short_description'] as String?,
  description: json['description'] as String?,
  level: courseLevelFromJson(json['level']),
  status: courseStatusFromJson(json['status']),
  durationHours: (json['duration_hours'] as num?)?.toInt(),
  capacity: (json['capacity'] as num?)?.toInt(),
  tuitionFee: (json['tuition_fee'] as num?)?.toDouble(),
  startDate: json['start_date'] == null
      ? null
      : DateTime.parse(json['start_date'] as String),
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
  coverImagePath: json['cover_image_path'] as String?,
  meta: json['meta'] as Map<String, dynamic>?,
  trainingCenter: json['trainingCenter'] == null
      ? null
      : TrainingCenterModel.fromJson(
          json['trainingCenter'] as Map<String, dynamic>,
        ),
  teachers: (json['teachers'] as List<dynamic>?)
      ?.map((e) => TeacherModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  schedules: (json['schedules'] as List<dynamic>?)
      ?.map((e) => CourseScheduleModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  media: (json['media'] as List<dynamic>?)
      ?.map((e) => CourseMediaModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  lessons: (json['lessons'] as List<dynamic>?)
      ?.map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'training_center_id': instance.trainingCenterId,
      'title': instance.title,
      'slug': instance.slug,
      'code': instance.code,
      'short_description': instance.shortDescription,
      'description': instance.description,
      'level': _$CourseLevelEnumMap[instance.level],
      'status': _$CourseStatusEnumMap[instance.status],
      'duration_hours': instance.durationHours,
      'capacity': instance.capacity,
      'tuition_fee': instance.tuitionFee,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'cover_image_path': instance.coverImagePath,
      'meta': instance.meta,
      'trainingCenter': instance.trainingCenter?.toJson(),
      'teachers': instance.teachers?.map((e) => e.toJson()).toList(),
      'schedules': instance.schedules?.map((e) => e.toJson()).toList(),
      'media': instance.media?.map((e) => e.toJson()).toList(),
      'lessons': instance.lessons?.map((e) => e.toJson()).toList(),
    };

const _$CourseLevelEnumMap = {
  CourseLevel.beginner: 'beginner',
  CourseLevel.intermediate: 'intermediate',
  CourseLevel.advanced: 'advanced',
};

const _$CourseStatusEnumMap = {
  CourseStatus.draft: 'draft',
  CourseStatus.published: 'published',
  CourseStatus.archived: 'archived',
};
