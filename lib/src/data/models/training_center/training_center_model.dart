// lib/src/data/models/training_center/training_center_model.dart
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:edufy_mobile/src/data/models/course/course_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'training_center_model.g.dart';

@CopyWith()
@JsonSerializable()
class TrainingCenterModel {
  final int? id;
  final String? name;
  final String? slug;
  final String? code;
  final String? email;
  final String? phone;
  final String? website;

  /// Avatar logo của trung tâm
  final String? avatar;

  /// Ảnh cover dùng cho trang detail
  @JsonKey(name: 'cover_image_path')
  final String? coverImagePath;

  /// Mô tả / giới thiệu trung tâm
  final String? description;

  /// Điểm rating trung bình (1–5)
  final double? rating;

  /// Tổng số lượt đánh giá
  @JsonKey(name: 'review_count')
  final int? reviewCount;

  @JsonKey(name: 'address_line1')
  final String? addressLine1;

  @JsonKey(name: 'address_line2')
  final String? addressLine2;

  final String? city;
  final String? state;
  final String? country;

  @JsonKey(name: 'postal_code')
  final String? postalCode;

  final String? timezone;

  final List<CourseModel> courses;

  /// Chứa thêm flag kiểu is_premium, map_url, v.v.
  final Map<String, dynamic>? meta;

  const TrainingCenterModel({
    this.id,
    this.name,
    this.slug,
    this.code,
    this.email,
    this.phone,
    this.website,
    this.avatar,
    this.coverImagePath,
    this.description,
    this.rating,
    this.reviewCount,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.timezone,
    this.courses = const [],
    this.meta,
  });

  factory TrainingCenterModel.fromJson(Map<String, dynamic> json) =>
      _$TrainingCenterModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrainingCenterModelToJson(this);
}
