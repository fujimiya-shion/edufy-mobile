// lib/src/data/models/course_media_model.dart
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_media_model.g.dart';

@CopyWith()
@JsonSerializable()
class CourseMediaModel {
  final String? id;

  @JsonKey(name: 'course_id')
  final int? courseId;

  /// video / image / pdf / etc.
  final String? type;
  final String? title;
  final String? url;

  @JsonKey(name: 'sort_order')
  final int? sortOrder;

  // final Map<String, dynamic>? meta;

  const CourseMediaModel({
    this.id,
    this.courseId,
    this.type,
    this.title,
    this.url,
    this.sortOrder,
    // this.meta,
  });

  factory CourseMediaModel.fromJson(Map<String, dynamic> json) =>
      _$CourseMediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseMediaModelToJson(this);
}
