// lib/src/data/models/lesson_model.dart
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:edufy_mobile/src/data/models/course/course_model.dart';
import 'package:edufy_mobile/src/shared/enums/enums.dart';
import 'package:json_annotation/json_annotation.dart';

import 'lesson_media_model.dart';

part 'lesson_model.g.dart';

LessonStatus? lessonStatusFromJson(dynamic status) {
  if(status == null) return null;

  final s = status.toString().toLowerCase();
  switch (s) {
    case '0': return LessonStatus.draft;
    case '1': return LessonStatus.published;
    case '2': return LessonStatus.locked;
    default: return null;
  }
}

@CopyWith()
@JsonSerializable(explicitToJson: true)
class LessonModel {
  final int? id;

  @JsonKey(name: 'course_id')
  final int? courseId;

  final String? title;
  final String? slug;
  final String? summary;

  @JsonKey(name: 'sort_order')
  final int? sortOrder;

  @JsonKey(name: 'status', fromJson: lessonStatusFromJson)
  final LessonStatus? status;

  final CourseModel? course;
  final List<LessonMediaModel>? media;

  const LessonModel({
    this.id,
    this.courseId,
    this.title,
    this.slug,
    this.summary,
    this.sortOrder,
    this.status,
    this.course,
    this.media,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);
}
