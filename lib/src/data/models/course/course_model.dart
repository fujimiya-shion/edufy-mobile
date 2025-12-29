// lib/src/data/models/course_model.dart
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:edufy_mobile/src/data/models/lesson/lesson_model.dart';
import 'package:edufy_mobile/src/data/models/teacher/teacher_model.dart';
import 'package:edufy_mobile/src/data/models/training_center/training_center_model.dart';
import 'package:edufy_mobile/src/shared/enums/enums.dart';
import 'package:json_annotation/json_annotation.dart';

import 'course_schedule_model.dart';
import 'course_media_model.dart';

part 'course_model.g.dart';

CourseStatus? courseStatusFromJson(dynamic v) {
  if (v == null) return null;

  final s = v.toString().toLowerCase();
  switch (s) {
    case '0': return CourseStatus.draft;
    case '1': return CourseStatus.archived;
    case '2': return CourseStatus.published;
    default: return null;
  }
}

CourseLevel? courseLevelFromJson(dynamic v) {
  if (v == null) return null;

  // int mapping
  if (v is num) {
    switch (v.toInt()) {
      case 0: return CourseLevel.beginner;
      case 1: return CourseLevel.intermediate;
      case 2: return CourseLevel.advanced;
      default: return null;
    }
  }

  // string mapping
  final s = v.toString().toLowerCase();
  switch (s) {
    case 'beginner': return CourseLevel.beginner;
    case 'intermediate': return CourseLevel.intermediate;
    case 'advanced': return CourseLevel.advanced;
    default: return null;
  }
}

dynamic courseLevelToJson(CourseLevel? v) => v?.name; // hoặc theo BE cần


@CopyWith()
@JsonSerializable(explicitToJson: true)
class CourseModel {
  final int? id;

  @JsonKey(name: 'training_center_id')
  final int? trainingCenterId;

  final String? title;
  final String? slug;
  final String? code;

  @JsonKey(name: 'short_description')
  final String? shortDescription;

  final String? description;

  @JsonKey(fromJson: courseLevelFromJson)
  final CourseLevel? level;
  @JsonKey(fromJson: courseStatusFromJson)
  final CourseStatus? status;

  @JsonKey(name: 'duration_hours')
  final int? durationHours;

  final int? capacity;

  @JsonKey(name: 'tuition_fee')
  final double? tuitionFee;

  @JsonKey(name: 'start_date')
  final DateTime? startDate;

  @JsonKey(name: 'end_date')
  final DateTime? endDate;

  @JsonKey(name: 'cover_image_path')
  final String? coverImagePath;

  final Map<String, dynamic>? meta;

  final TrainingCenterModel? trainingCenter;
  final List<TeacherModel>? teachers;
  final List<CourseScheduleModel>? schedules;
  final List<CourseMediaModel>? media;
  final List<LessonModel>? lessons;

  const CourseModel({
    this.id,
    this.trainingCenterId,
    this.title,
    this.slug,
    this.code,
    this.shortDescription,
    this.description,
    this.level,
    this.status,
    this.durationHours,
    this.capacity,
    this.tuitionFee,
    this.startDate,
    this.endDate,
    this.coverImagePath,
    this.meta,
    this.trainingCenter,
    this.teachers,
    this.schedules,
    this.media,
    this.lessons,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}
