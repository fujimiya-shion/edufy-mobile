import 'package:copy_with_extension/copy_with_extension.dart';

part 'course_dto.g.dart';

@CopyWith()
class CourseFilterRequest {
  final String keyword;
  final int? trainingCenterId;
  final String? level;
  final String? status;
  final double? minFee;
  final double? maxFee;
  final int? teacherId;
  final bool? hasMedia;
  final String? sort;
  final int page;
  final int perPage;

  const CourseFilterRequest({
    this.keyword = '',
    this.trainingCenterId,
    this.level,
    this.status,
    this.minFee,
    this.maxFee,
    this.teacherId,
    this.hasMedia,
    this.sort,
    this.page = 1,
    this.perPage = 10,
  });

  CourseFilterRequest resetPage() => copyWith(page: 1);

  Map<String, dynamic> toQuery() {
    final Map<String, dynamic> q = {
      'page': page,
      'perpage': perPage,
    };

    final kw = keyword.trim();
    if (kw.isNotEmpty) q['keyword'] = kw;
    if (trainingCenterId != null) q['training_center_id'] = trainingCenterId;
    if (level != null && level!.trim().isNotEmpty) q['level'] = level!.trim();
    if (status != null && status!.trim().isNotEmpty) q['status'] = status!.trim();
    if (minFee != null) q['min_fee'] = minFee;
    if (maxFee != null) q['max_fee'] = maxFee;
    if (teacherId != null) q['teacher_id'] = teacherId;
    if (hasMedia != null) q['has_media'] = hasMedia;
    if (sort != null && sort!.trim().isNotEmpty) q['sort'] = sort!.trim();

    return q;
  }
}
